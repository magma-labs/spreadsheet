# frozen_string_literal: true

module Spreadsheet
  # Cell is a most granular component in a spreadsheet
  class Cell < Spreadsheet::BaseComponent
    attr_reader :id, :value, :colspan, :opts

    include Spreadsheet::Cell::Controller
    include Spreadsheet::Cell::Menu

    renders_one :cell_actions_menu

    def initialize(id:, value: '&nbsp;'.html_safe, colspan: 1, **opts)
      @id = id
      @value = value
      @colspan = colspan

      # let row's options serve as defaults for this cell
      @opts =  row.opts.merge(opts)

      concat_classnames
    end

    def component_classnames
      CssClassString::Helper.new(
        id,
        "col-span-#{colspan}",
        numeric_class,
        @opts[:classnames],
        readonly: readonly_css,
        money: opts[:money],
        error: error
      ).to_s
    end

    def content
      super || value
    end

    def input_data
      {
        "#{component_controller}": { target: "input"},
        action: "change->#{component_controller}#change blur->#{component_controller}#hideInput"
      }
    end

    def disabled
      opts[:disabled]
    end

    def dragsum
      opts[:dragsum]
    end

    def error
      opts[:error]
    end

    def expander
      opts[:expander]
    end

    def nesting_level
      opts[:nesting_level]
    end

    def numeric_class
      return unless value.to_s =~ /\$[\d,]+\.\d*/

      CssClassString::Helper.new('text-right', negative: numeric_value.negative?).to_s
    end

    def content_classnames
      CssClassString::Helper.new(
        opts[:content_classnames]
      )
    end

    def readonly
      opts[:readonly]
    end

    def readonly_css
      opts[:apply_readonly_css].nil? ? readonly : opts[:apply_readonly_css]
    end

    def render?
      row.display_cell?(id)
    end

    private

    def numeric_value
      case value
      when String
        value.gsub(/[^\d.-]/, '').to_f
      when Numeric
        value
      end
    end

    def row
      RequestStore.store[:row] || Spreadsheet::Row.new(id: "parent-#{@id}")
    end

    def data_actions
      [
        "keyup->#{component_controller}#navigate",
        'mousedown->spreadsheet--row#highlight',
        "focus->#{component_controller}#focus"
      ].join(' ')
    end

    def default_data
      {
        type: id,
        value: value,
        nesting_level: nesting_level,
        controller: component_controller,
        action: data_actions,
        error: error
      }
    end

    def concat_classnames
      return unless row.opts[:classnames] && row.opts[:classnames] != @opts[:classnames]

      @opts[:classnames] = @opts[:classnames].concat(" #{row.opts[:classnames]}")
    end
  end
end
