module Spreadsheet
  class Configuration
    attr_reader :stimulus_path

    def initialize(stimulus_path: nil) # stimulus_entry_path
      @stimulus_path = stimulus_path || Rails.root.join('app/javascript/controllers/index.js')
    end
  end
end
