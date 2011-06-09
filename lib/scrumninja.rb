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
  
  def self.stories(api_key,project_id)
    client(api_key).stories project_id
  end
  
end