require ::File.expand_path('../scrumninja/version.rb', __FILE__)
require ::File.expand_path('../scrumninja/client.rb', __FILE__)

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
  
  def self.project_stories(api_key,project_id)
    client(api_key).project_stories project_id
  end
  
  def self.project_backlog(api_key,project_id)
    client(api_key).project_backlog project_id
  end
  
  def self.project_card_wall(api_key,project_id)
    client(api_key).project_card_wall project_id
  end
  
  def self.story_tasks(api_key,story_id)
     client(api_key).story_tasks story_id
   end
end