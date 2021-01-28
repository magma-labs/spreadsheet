run 'yarn add @shoelace-style/shoelace copy-webpack-plugin'

file_path = 'app/javascript/packs/application.js'
lines = File.open(file_path, 'r', &:readlines)
last_import = lines.select { |line| line =~ /\A(require|import)/ }.last

inject_into_file file_path, after: last_import do
  "\n#{File.open("#{__dir__}/templates/shoelace_import.js").read}"
end

append_to_file file_path do
  "\n#{File.open("#{__dir__}/templates/shoelace_register.js").read}"
end

inject_into_file 'config/webpack/environment.js', after: "require('@rails/webpacker')" do
  "\n#{File.open("#{__dir__}/templates/shoelace_webpack.js").read}"
end
