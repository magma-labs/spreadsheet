# frozen_string_literal: true

module Spreadsheet
  # a base component to define common behaviour for Spreadsheet components
  class BaseComponent < ViewComponent::Base
    def initialize(**opts)
      @opts = opts
    end

    def random_id
      "random_#{(rand * 1_000_000_000_000).to_i}"
    end

    def component_controller
      @opts[:controller] || default_component_controller
    end

    def component_classnames
      @opts[:classnames]
    end
  end
end
