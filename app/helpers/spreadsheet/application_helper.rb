require "webpacker/helper"

module Spreadsheet
  module ApplicationHelper
    include ::Webpacker::Helper

    def current_webpacker_instance
      Spreadsheet.webpacker
    end
  end
end
