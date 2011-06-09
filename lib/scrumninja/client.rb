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
    
    def stories(project_id,options={})
      response = get "http://scrumninja.com/projects/#{project_id}/stories.xml", options
      response.stories
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