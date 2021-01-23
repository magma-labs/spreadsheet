# frozen_string_literal: true

module Spreadsheet
  # a wrapper component for spreadsheet rows
  class RowGroup < Spreadsheet::BaseComponent
    attr_reader :id, :opts

    with_content_areas :header, :body

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

    private

    def default_component_controller
      'spreadsheet--row-group'
    end
  end
end
