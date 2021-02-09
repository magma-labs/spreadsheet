# frozen_string_literal: true

module Spreadsheet
  class Cell
    # Spreadsheet Cell, menu related methods
    module Menu
      def actions_menu_options
        opts[:actions_menu_options] || {}
      end

      def actions_menu_icon
        actions_menu_options[:icon] || 'three-dots'
      end

      def actions_menu_label
        actions_menu_options[:label] || ''
      end

      def actions_menu_label_classes
        actions_menu_options[:label_classes] || ''
      end
    end
  end
end
