file_path = Spreadsheet.config.stimulus_path
lines = File.open(file_path, "r") { |f| f.readlines }
last_import = lines.select { |line| line =~ /\A(require|import)/ }.last

say "Registering Spreadsheet Stimulus controllers in #{file_path}"

inject_into_file file_path, File.open("#{__dir__}/templates/spreadsheet_import.js").read, after: last_import

append_to_file "#{file_path}" do
  "\n" + File.open("#{__dir__}/templates/spreadsheet_stimulus_register.js").read
end
