# frozen_string_literal: true

module Spreadsheet
  # a wrapper component for spreadsheet rows
  class RowGroup < Spreadsheet::BaseComponent
    attr_reader :id, :opts

    renders_one :row_group_header
    renders_one :row_group_body

    def initialize(id:, **opts)
      @id = id
      @opts = opts
      @level =
        @row_parent = RequestStore.store[:row_parent]
      RequestStore.store[:row_parent] = self
    end

    def classnames
      CssClassString::Helper.new(id, @opts[:classnames], draggable: @opts[:draggable],
                                                         collapsed: @opts[:collapsed]).to_s
    end

    def draggable
      opts[:draggable]
    end

    def level
      @row_parent.level + 1
    end

    def sortable_controller
      opts[:sortable_controller] || default_sortable_controller
    end

    def sortable_data
      opts[:sortable_extra_data] ? default_sortable_data.merge(opts[:sortable_extra_data]) : default_sortable_data
    end

    private

    def default_component_controller
      'spreadsheet--row-group'
    end

    def default_sortable_controller
      'spreadsheet--sortable'
    end

    def default_data
      {
        controller: component_controller,
        action: "mousedown->#{component_controller}#highlight"
      }
    end

    def default_sortable_data
      {
        "#{component_controller}": { target: "collapseContainer" },
        controller: sortable_controller
      }
    end
  end
end
