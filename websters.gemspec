# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "websters"
  s.version     = "0.0.1"
  s.authors     = ["Jeremy B. Merrill"]
  s.email       = ["jeremybmerrill@gmail.com"]
  s.summary     = "Create models and import data from a data dictionary."
  s.description = "Create models and import data from a data dictionary."
  s.license     = 'MIT'
  
  s.files = Dir["{lib}/**/*", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.2.0"
  s.add_dependency "activerecord-import", ">= 0.4"

  s.add_development_dependency "sqlite3"
end