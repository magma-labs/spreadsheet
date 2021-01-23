# frozen_string_literal: true

require_relative './row'

module Spreadsheet
  # Header is a special Row component use it for heading in your sheet
  class Header < Row
    attr_reader :columns, :locked

    with_content_areas :context_menu

    def initialize(id:, columns:, locked: {}, **opts)
      super
      @columns = columns.map(&:to_sym)
      @colspans = opts[:colspans] || {}
      @classnames = opts[:classnames] || {}
      @locked = locked.map(&:to_sym)
      @labels = opts[:labels] || {}
    end

    def component_classnames
      grid = @classnames[:grid] || default_grid_classnames
      padding = @classnames[:padding] || default_padding_classnames
      "#{grid} #{padding} relative bg-gray-500 text-center sticky top-0 z-10"
    end

    def default_grid_classnames
      'grid grid-flow-col grid-cols-auto gap-0 auto-cols-fr'
    end

    def default_padding_classnames
      CssClassString::Helper.new('pl-1', 'pr-8' => show_dropdown?)
    end

    def default_cell_grid_classnames(id)
      "col-span-#{colspan_for(id)}"
    end

    def classnames_for(id)
      grid = @classnames[:cell_grid] || default_cell_grid_classnames(id)
      [@classnames[:all], @classnames[id], "#{grid} #{id}"].compact.join(' ')
    end

    def colspan_for(id)
      @colspans[id] || 1
    end

    def label_for(id)
      @labels[id] || id.to_s.titleize
    end

    def show_dropdown?
      context_menu.present?
    end

    private

    def default_component_controller
      'spreadsheet--header'
    end
  end
end
