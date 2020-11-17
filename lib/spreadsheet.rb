require "rails"
require "view_component"
require "spreadsheet/engine"
require "spreadsheet/configuration"
require "request_store"
require "css-class-string"
require "haml"

module Spreadsheet
  class << self
    def config
      @config || Configuration.new
    end
  end

  def self.configure(block = nil)
    @config || Configuration.new
    yield(@config) if block
  end
end
