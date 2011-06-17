require 'scrumninja/client'
require 'scrumninja/version'

module ScrumNinja
  # Alias for ScrumNinja::Client.new
  #
  # @return [ScrumNinja::Client]
  def self.client(options={})
    ScrumNinja::Client.new(options)
  end

  def self.projects(api_key)
    client(api_key).projects
  end
  
  def self.project(api_key,project_id)
    client(api_key).project project_id
  end
  
  def self.project_stories(api_key,project_id)
    client(api_key).project_stories project_id
  end
  
  def self.project_backlog(api_key,project_id)
    client(api_key).project_backlog project_id
  end
  
  def self.project_sprints(api_key,project_id)
    client(api_key).project_sprints project_id
  end
  
  def self.project_card_wall(api_key,project_id)
    client(api_key).project_card_wall project_id
  end
  
  def self.project_roles(api_key,project_id)
    client(api_key).project_roles project_id
  end
  
  def self.project_sprint(api_key,project_id,sprint_id)
    client(api_key).project_sprint project_id, sprint_id
  end
  
  def self.project_story(api_key,project_id,story_id)
    client(api_key).project_story project_id, story_id
  end
  
  def self.story_tasks(api_key,story_id)
    client(api_key).story_tasks story_id
  end
  
  def self.project_burndown(api_key,project_id)
    client(api_key).project_burndown project_id
  end
end