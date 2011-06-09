# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "scrumninja/version"

Gem::Specification.new do |s|
  s.name = "scrumninja"
  s.version     = ScrumNinja::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors = ["Javier Muniz"]
  s.email = "javier@granicus.com"
  s.summary = "Scrumninja API Wrapper"
  s.homepage = "http://github.com/gov20cto/scrumninja"
  s.description = "Wrapper for the Scrumninja backlog/sprint management tool."
  
  s.rubyforge_project = "scrumninja"
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_development_dependency('rake', '~> 0.8')
  s.add_development_dependency('rspec', '~> 2.6')
  s.add_development_dependency('nokogiri', '~> 1.4')
  s.add_development_dependency('webmock', '~> 1.5')
  
  s.add_dependency('hashie', '~> 1.0.0')
  s.add_dependency('faraday','~> 0.6.0')
  s.add_dependency('faraday_middleware', '~> 0.6.0')
  s.add_dependency('multi_xml', '~> 0.2.0')
end