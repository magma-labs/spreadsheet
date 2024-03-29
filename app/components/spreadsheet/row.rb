# frozen_string_literal: true

module Spreadsheet
  # a wrapper component for spreadsheet cells
  class Row < Spreadsheet::BaseComponent
    attr_reader :id, :parent, :opts

    renders_one :row_actions_menu

    def initialize(id:, visible_cells: [], **opts)
      @id = id
      @visible_cells = visible_cells.map(&:to_sym)
      @cells = []
      @opts = opts

      RequestStore.store[:row] = self
    end

    def component_classnames
      CssClassString::Helper.new(id, @opts[:classnames], draggable: @opts[:draggable], 'pl-3' => selectable,
                                                         'pr-8' => show_dropdown?).to_s
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

    def selectable_menu
      opts[:selectable_menu]
    end

    def draggable
      opts[:draggable]
    end

    def nesting_level
      opts[:nesting_level] || 0
    end

    def show_dropdown?
      selectable_menu || row_actions_menu.present?
    end

    private

    def default_component_controller
      'spreadsheet--row'
    end

    def default_data
      {
        controller: component_controller,
        action: "mousedown->#{component_controller}#highlight",
        nesting_level: nesting_level
      }
    end
  end
end
