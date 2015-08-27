$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "scheduler/core/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
    s.name        = "scheduler_core"
    s.version     = Scheduler::Core::VERSION
    s.authors     = ["Alex Rocha"]
    s.email       = ["arocha@motorola.com"]
    s.homepage    = "TODO"
    s.summary     = "TODO: Summary of Scheduler::Core."
    s.description = "TODO: Description of Scheduler::Core."
    s.license     = "MIT"

    s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
    s.test_files = Dir["test/**/*"]

    s.add_dependency "rails", "~> 4.2.3"
    s.add_dependency "multi_json", "~> 1.11.2"
    s.add_dependency "json", "~> 1.8.3"
    s.add_dependency "deface"
    s.add_development_dependency "sqlite3"
    s.add_development_dependency "rspec-rails"
end
