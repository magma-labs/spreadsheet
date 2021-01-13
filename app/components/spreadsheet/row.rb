class Spreadsheet::Row < Spreadsheet::BaseComponent
  attr_reader :id
  attr_reader :parent
  attr_reader :opts

  with_content_areas :actions_menu

  def initialize(id:, visible_cells: [], **opts)
    @id = id
    @visible_cells = visible_cells.map(&:to_sym)
    @cells = []
    @opts = opts

    RequestStore.store[:row] = self
  end

  def component_classnames
    CssClassString::Helper.new(id, @opts[:classnames], draggable: @opts[:draggable], "pl-3" => selectable, "pr-8" => show_dropdown?).to_s
  end

  def display_cell?(id)
    # if no visible cells defined then show all
    @visible_cells.empty? || @visible_cells.include?(id.to_sym)
  end

  def draghandle
    opts[:draghandle]
  end

  def selectable
    opts[:selectable]
  end

  def draggable
    opts[:draggable]
  end

  def nesting_level
    opts[:nesting_level] || 0
  end

  def show_dropdown?
    selectable || actions_menu.present?
  end

  def data
    default_data = {
      controller: component_controller,
      action: "mousedown->#{component_controller}#highlight",
      nesting_level: nesting_level
    }
    default_data.merge!(opts[:extra_data]) if opts[:extra_data]
    default_data
  end

  private

  def default_component_controller
    "spreadsheet--row"
  end
end
