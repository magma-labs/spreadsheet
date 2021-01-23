# frozen_string_literal: true

require 'test_helper'

module Spreadsheet
  class Test < ActiveSupport::TestCase
    test 'truth' do
      assert_kind_of Module, Spreadsheet
    end
  end
end
