# frozen_string_literal: true

module Spreadsheet
  # This is a primary location to extend or customize preferences, like stimulus path
  class Configuration
    attr_reader :stimulus_path

    # stimulus_entry_path
    def initialize(stimulus_path: nil)
      @stimulus_path = stimulus_path || Rails.root.join('app/javascript/controllers/index.js')
    end
  end
end
