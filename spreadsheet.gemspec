# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'spreadsheet/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'spreadsheet'
  spec.version     = Spreadsheet::VERSION
  spec.authors     = ['César Carruitero']
  spec.email       = ['ccarruitero@protonmail.com']
  spec.homepage    = 'https://github.com/magma-labs/spreadsheet'
  spec.summary     = 'A Spreadsheet view_component for your Rails app'
  spec.license     = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('~> 2.7')

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'css-class-string'
  spec.add_dependency 'haml'
  spec.add_dependency 'rails'
  spec.add_dependency 'request_store'
  spec.add_dependency 'stimulus_reflex'
  spec.add_dependency 'view_component'

  spec.add_development_dependency 'capybara'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'webpacker'
end
