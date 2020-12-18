class Spreadsheet::Cell < Spreadsheet::BaseComponent
  attr_reader :id
  attr_reader :value
  attr_reader :colspan
  attr_reader :opts

  with_content_areas :actions_menu

  def initialize(id:, value: "&nbsp;".html_safe, colspan: 1, **opts)
    @id = id
    @value = value
    @colspan = colspan

    # let row's options serve as defaults for this cell
    @opts =  row.opts.merge(opts)
    @opts[:classnames] = @opts[:classnames].concat(" #{row.opts[:classnames]}") if row.opts[:classnames] && row.opts[:classnames] != @opts[:classnames]
  end

  def component_classnames
    CssClassString::Helper.new(id, "col-span-#{colspan}", numeric_class, @opts[:classnames], readonly: readonly, money: opts[:money], error: error).to_s
  end

  def content
    super || value
  end

  def data
    { type: id,
      value: value,
      nesting_level: nesting_level,
      controller: "spreadsheet--cell",
      action: "keyup->spreadsheet--cell#navigate mousedown->spreadsheet--row#highlight focus->spreadsheet--cell#focus",
      error: error }
  end

  def input_data
    {
      target: "spreadsheet--cell.input",
      action: "change->spreadsheet--cell#change blur->spreadsheet--cell#hideInput"
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
    return unless value.to_s =~ /\$[\d\,]+\.[\d\d]*/

    CssClassString::Helper.new("text-right", negative: (numeric_value < 0)).to_s
  end

  def readonly
    opts[:readonly]
  end

  def render?
    row.display_cell?(id)
  end

  def actions_menu_options
    opts[:actions_menu_options] || {}
  end

  def actions_menu_icon
    actions_menu_options[:icon] || "three-dots"
  end

  private

  def numeric_value
    case value
    when String
      value.gsub(/[^\d\.-]/,"").to_f
    when Numeric
      value
    end
  end

  def row
    RequestStore.store[:row] || Spreadsheet::Row.new(id: "parent-#{@id}")
  end
end
