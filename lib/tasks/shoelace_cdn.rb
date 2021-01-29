inject_into_file 'app/views/layouts/application.html.erb', before: '</head>' do
  "\n#{File.open("#{__dir__}/templates/shoelace_cdn.html").read}"
end
