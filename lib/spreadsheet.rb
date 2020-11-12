require "spreadsheet/engine"
require "spreadsheet/configuration"

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
