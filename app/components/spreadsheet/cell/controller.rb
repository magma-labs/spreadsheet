# frozen_string_literal: true

module Spreadsheet
  class Cell
    # Spreadsheet Cell, controller methods
    module Controller
      def component_controller
        # We use `cell_controller` option here instead `controller` like in other components
        # to avoid conflicts, since cell receive all row options too
        @opts[:cell_controller] || default_component_controller
      end

      def parent_component_controller
        @opts[:parent_controller] || default_parent_component_controller
      end

      private

      def default_component_controller
        'spreadsheet--cell'
      end

      def default_parent_component_controller
        'spreadsheet--row-group'
      end
    end
  end
end
