begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rails/generators/rails/app/app_generator'
require 'fileutils'

desc 'Generates a dummy app for testing'
task :test_app do
  dummy_path = 'test/dummy'

  FileUtils.remove_dir(dummy_path) unless Dir[dummy_path].empty?

  puts "Generating dummy Rails application..."
  opts = [dummy_path] +  %W[-B --skip-gemfile -q -T -G --skip-keeps --skip-listen
                            -P --skip-webpack-install --skip-spring --skip-bootsnap]
  Rails::Generators::AppGenerator.start opts
end

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

task default: :test
