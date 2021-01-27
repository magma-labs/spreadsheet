source_paths.unshift(File.expand_path('dummy', __dir__))

directory 'controllers', 'app/controllers'
directory 'views', 'app/views'
route "get '/integration/:component' => 'integration#show'"

inject_into_file 'config/application.rb', after: 'require "sprockets/railtie"' do
  '
  require "webpacker"
  require "webpacker/railtie"
  require "spreadsheet"
  '
end

after_bundle do
  rake 'spreadsheet:install'
end
