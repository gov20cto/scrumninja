require 'helper'

# Keep all the stuff that could change up here
API_KEY = "a0d550405d37584fff59dd9e86cbe0cd88188e35"
PROJECT_ID = 8991

# The projects method
describe ScrumNinja, ".projects" do
  before do
    stub_request(:get, 'https://scrumninja.com/projects.xml').
    with(:query => {:api_key => API_KEY}).
    to_return(:body => fixture('projects.xml'), :headers => {'Content-Type' => 'application/xml; charset=utf-8'})
  end

  it "should request the correct resource" do
    ScrumNinja.projects(API_KEY)
    a_request(:get, 'https://scrumninja.com/projects.xml').
    with(:query => {:api_key => API_KEY}).
    should have_been_made
  end

  it "should return the correct results" do
    projects = ScrumNinja.projects(API_KEY)
    projects.should be_an Array
    projects[0].name.should == "Tutorial Project"
    puts projects[0].link
  end
end

# The stories method
describe ScrumNinja, ".stories" do
  before do
    stub_request(:get, "http://scrumninja.com/projects/#{PROJECT_ID}/stories.xml").
    with(:query => {:api_key => API_KEY}).
    to_return(:body => fixture('stories.xml'), :headers => {'Content-Type' => 'application/xml; charset=utf-8'})
  end

  it "should request the correct resource" do
    ScrumNinja.stories(API_KEY,PROJECT_ID)
    a_request(:get, "http://scrumninja.com/projects/#{PROJECT_ID}/stories.xml").
    with(:query => {:api_key => API_KEY}).
    should have_been_made
  end

  it "should return the correct results" do
    stories = ScrumNinja.stories(API_KEY,PROJECT_ID)
    stories.should be_an Array
    stories[0].name.should == "Infrastructure for project"
    puts stories[0].link
  end
end

