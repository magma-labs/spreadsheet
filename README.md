# Spreadsheet
A spreadsheet view_component for your Rails app

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'spreadsheet', github: 'magma-labs/spreadsheet'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install spreadsheet
```

Then run the installation task
```bash
$ rake spreadsheet:install
```

> **_NOTE:_** Spreadsheet's ViewComponents use [shoelace](https://shoelace.style/) and [tailwind](https://tailwindcss.com/) in templates,
but for now these packages aren't included with the installation task so you will
need to install manually

## Usage

After install you can use Spreadsheet's ViewComponents in your templates

```haml
  = render Spreadsheet::Cell.new(id: 'cell-id', value: 'A Spreadsheet Cell')
```

Most components accept the following options:
- `classnames`: For agregate css classes to use with your component
- `colspan`: For define colspan to be applied in a component
- `component_controller`: For use a custom stimulus controller with a component
- `extra_data`: For extend default dataset added in the component template

## Development

### Setup project locally
In development, when editing js files you will need to [link your local repository](https://classic.yarnpkg.com/en/docs/cli/link/)
and run [webpack-dev-server script from `webpacker`](https://github.com/rails/webpacker#development) in your rails application

In brief, the process is 2 steps:
* Run `yarn link` in this directory.
* Run `yarn link "spreadsheet"` in the project that has the dependency.

## Contributing
Bug reports and pull requests are welcome on GitHub at [https://github.com/magma-labs/spreadsheet](https://github.com/magma-labs/spreadsheet).

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
