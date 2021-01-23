# frozen_string_literal: true

bin_path = ENV['BUNDLE_BIN'] || Rails.root.join('bin')
template_path = File.expand_path('./install.rb', __dir__).freeze

namespace :spreadsheet do
  desc 'Install/Setup Spreadsheet in rails application'
  task :install do
    exec "#{bin_path}/rails app:template LOCATION=#{template_path}"
  end
end
