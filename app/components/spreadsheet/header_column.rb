# frozen_string_literal: true

module Spreadsheet
  # A HeaderColumn is used to represent a column in Header
  #
  # options:
  # * `id`
  # * `classnames`
  # * `child_components`
  # * `label`
  class HeaderColumn < BaseComponent
    def id
      @opts[:id]
    end

    def classnames
      @opts[:classnames]
    end

    def label
      @opts[:label]
    end

    def child_components
      @opts[:child_components]
    end

    def content
      super || label
    end
  end
end
