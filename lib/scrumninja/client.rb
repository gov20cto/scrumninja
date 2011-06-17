require 'faraday_middleware'

module ScrumNinja
  class Client
    def initialize(key)
      @api_key = key
    end
  
    def projects(options={})
      response = get 'https://scrumninja.com/projects.xml', options
      response.projects
    end
    
    def project(project_id,options={})
      response = get "http://scrumninja.com/projects/#{project_id}.xml", options
      response.project
    end
    
    def project_stories(project_id,options={})
      response = get "http://scrumninja.com/projects/#{project_id}/stories.xml", options
      response.stories
    end
    
    def project_backlog(project_id,options={})
      response = get "http://scrumninja.com/projects/#{project_id}/backlog/index.xml", options
      response.sprints
    end
    
    def project_sprints(project_id,options={})
      response = get "http://scrumninja.com/projects/#{project_id}/sprints.xml", options
      response.sprints
    end
    
    def project_card_wall(project_id,options={})
      response = get "http://scrumninja.com/projects/#{project_id}/card_wall.xml", options
      response.tasks
    end
    
    def project_roles(project_id,options={})
      response = get "http://scrumninja.com/projects/#{project_id}/project_roles.xml", options
      response.project_roles
    end
    
    def project_sprint(project_id,sprint_id,options={})
      response = get "http://scrumninja.com/projects/#{project_id}/sprints/#{sprint_id}.xml", options
      response.sprint
    end
    
    def project_story(project_id,story_id,options={})
      response = get "http://scrumninja.com/projects/#{project_id}/stories/#{story_id}.xml", options
      response.story
    end
    
    def story_tasks(story_id,options={})
      response = get "http://scrumninja.com/stories/#{story_id}/tasks.xml", options
      response.tasks
    end
    
    def project_burndown(project_id,options={})
      burndown = Hashie::Mash.new
      card_wall = project_card_wall project_id, options
      sprints = project_sprints project_id, options

      card_wall = [] if card_wall.nil?
      sprints = [] if sprints.nil?

      start_date = sprints[0].starts_on.to_date
      end_date =  sprints[0].ends_on.to_date

      burndown.start = start_date.to_time.to_i * 1000
      burndown.length = (end_date - start_date).to_i + 1
      days_passed = (Date.today - start_date).to_i + 1
      # for each day in the sprint
      burndown.estimates = []
      days_passed.times do |i|
        start_time = (start_date + i).to_time
        end_time = (start_date + i + 1).to_time
        total_hours = 0
        card_wall.each do |task|
          if task.created_at < end_time
            if task.done_at.nil? or task.done_at > end_time
              # we have a task that counts towards today, dig into estimates
              if task.estimates.estimate.is_a? Array then
                estimate_hours = 0
                task.estimates.estimate.each do |estimate|
                  estimate_day = estimate.date.to_date
                  break if(estimate_day.to_time > end_time)
                  estimate_hours = task.estimates.estimate[0].hours.to_f
                end
                total_hours += estimate_hours
              else
                total_hours += task.estimates.estimate.hours.to_f
              end
            end
          end
        end
        burndown.estimates << total_hours
      end
      burndown
    end
    
    private
    
    def connection
      options = {
        :headers => {'Accept' => 'application/xml'},
        :ssl => {:verify => false}
      }
      
      Faraday::Connection.new(options) do |builder|
        builder.use Faraday::Request::Multipart
        builder.use Faraday::Response::Mashify
        builder.use Faraday::Response::ParseXml
        builder.adapter(Faraday.default_adapter)
      end
    end
    
    def get(path,options)
      options.merge!({:api_key => @api_key})
      response = connection.get do |request|
        request.url path, options
      end
      response.body
    end
  end
end