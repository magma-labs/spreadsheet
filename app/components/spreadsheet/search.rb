module Spreadsheet
  class Search < BaseComponent
    def initialize(**opts)
      @opts = opts
    end

    private

    def default_component_controller
      'spreadsheet--search'
    end
  end
end
