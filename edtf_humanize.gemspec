$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "edtf_humanize/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "edtf_humanize"
  s.version     = EdtfHumanize::VERSION
  s.authors     = ["Cory Lown"]
  s.email       = ["cory.lown@duke.edu"]
  s.homepage    = "TODO"
  s.summary     = "Summary of EdtfHumanize."
  s.description = "Description of EdtfHumanize."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.2"
  s.add_dependency "edtf", "~> 2.3.0"

  s.add_development_dependency "sqlite3"
end
