require 'helper'

describe ScrumNinja, ".projects" do
  before do
    stub_request(:get, 'https://scrumninja.com/api/projects.xml').
    with(:query => {:api_key => 'a0d550405d37584fff59dd9e86cbe0cd88188e35'}).
    to_return(:body => fixture('projects.xml'), :headers => {'Content-Type' => 'application/xml; charset=utf-8'})
  end

  it "should request the correct resource" do
    ScrumNinja.projects({:api_key => 'a0d550405d37584fff59dd9e86cbe0cd88188e35'})
    a_request(:get, 'https://scrumninja.com/api/projects.xml').
    with(:query => {:api_key => 'a0d550405d37584fff59dd9e86cbe0cd88188e35'}).
    should have_been_made
  end

  it "should return the correct results" do
    test = ScrumNinja.projects({:api_key => 'a0d550405d37584fff59dd9e86cbe0cd88188e35'})
    puts test.inspect
    test.should be_an Hash
  end
end

