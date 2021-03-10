# frozen_string_literal: true

file_path = Spreadsheet.config.stimulus_path

unless Pathname.new(file_path).exist?
  run 'rails webpacker:install:stimulus'
end

lines = File.open(file_path, 'r', &:readlines)
last_import = lines.select { |line| line =~ /\A(require|import)/ }.last

say "Registering Spreadsheet Stimulus controllers in #{file_path}"

inject_into_file file_path, File.open("#{__dir__}/templates/spreadsheet_import.js").read, after: last_import

append_to_file file_path.to_s do
  "\n#{File.open("#{__dir__}/templates/spreadsheet_stimulus_register.js").read}"
end

say 'Installing Spreadsheet js package'
if Rails.env.test?
  inside File.expand_path('../../.') do
    run 'yarn link'
  end
  run 'yarn link @magmalabs/spreadsheet'
end
run 'yarn add @magmalabs/spreadsheet'
