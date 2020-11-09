$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "spreadsheet/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "spreadsheet"
  spec.version     = Spreadsheet::VERSION
  spec.authors     = ["César Carruitero"]
  spec.email       = ["ccarruitero@protonmail.com"]
  spec.homepage    = "https://github.com/magma-labs/spreadsheet"
  spec.summary     = "A Spreadsheet view_component for your Rails app"
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails"

  spec.add_development_dependency "sqlite3"
end
