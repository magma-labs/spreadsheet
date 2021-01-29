# frozen_string_literal: true


def install_cmd(task_name)
  bin_path = ENV['BUNDLE_BIN'] || Rails.root.join('bin')
  template_path = File.expand_path("./#{task_name}.rb", __dir__).freeze
  "#{bin_path}/rails app:template LOCATION=#{template_path}"
end

namespace :spreadsheet do
  desc 'Install/Setup Spreadsheet in rails application'
  task :install do
    exec install_cmd('install')
  end

  namespace :install do
    desc 'Install Shoelace'
    task :shoelace do
      exec install_cmd('shoelace')
    end

    namespace :shoelace do
      desc 'Setup Shoelace from CDN'
      task :cdn do
        exec install_cmd('shoelace_cdn')
      end
    end
  end
end
