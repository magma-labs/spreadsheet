# frozen_string_literal: true

module Spreadsheet
  # A Search view_component
  class Search < BaseComponent
    private

    def default_component_controller
      'spreadsheet--search'
    end

    def default_data
      {
        controller: component_controller,
        action: "toggle-search@window->#{component_controller}#toggleSearch"
      }
    end
  end
end
