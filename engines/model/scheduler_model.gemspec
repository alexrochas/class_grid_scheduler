$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "scheduler/model/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "scheduler_model"
  s.version     = Scheduler::Model::VERSION
  s.authors     = ["Alex Rocha"]
  s.email       = ["arocha@motorola.com"]
  s.homepage    = "http://alexrochas.github.io"
  s.summary     = "Summary of Scheduler::Model."
  s.description = "Description of Scheduler::Model."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.3"

  s.add_dependency "deface"
end
