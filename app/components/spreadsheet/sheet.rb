# frozen_string_literal: true

module Spreadsheet
  # Sheet is a wrapper for all Spreadsheet components
  class Sheet < Spreadsheet::BaseComponent
    def initialize(**opts)
      super

      RequestStore.store[:row_parent] = self
      @classnames = opts[:classnames] || {}
    end

    def level
      0
    end

    def data
      {
        controller: component_controller,
        action: component_actions
      }
    end

    def component_classnames
      @classnames
    end

    private

    def component_actions
      [
        "dragstart@document->#{component_controller}#startSum",
        "dragenter@document->#{component_controller}#calculateSum"
      ].join(' ')
    end

    def default_component_controller
      'spreadsheet--sheet'
    end
  end
end
