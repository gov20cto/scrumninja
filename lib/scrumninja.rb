require 'scrumninja/client'
require 'scrumninja/version'

module ScrumNinja
  # Alias for FccReboot::Client.new
  #
  # @return [FccReboot::Client]
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
  
  def self.story_tasks(api_key,story_id)
     client(api_key).story_tasks story_id
  end
end