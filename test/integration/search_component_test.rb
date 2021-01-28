require 'application_system_test_case'

class SeachComponentIntegrationTest < ApplicationSystemTestCase
  setup do
    Webpacker.compile
    # Webpacker::Manifest.load
  end

  test 'toggle search with ctrl-f keys' do
    visit '/integration/search'
    assert_selector '.spreadsheet--search'
    find('body').native.send_keys [:control, 'f']
    assert_no_selector '.spreadsheet--search'
  end

  test 'toggle search with cancel button' do
    skip
    visit '/integration/search'
    assert_selector '.spreadsheet--search'
    assert_no_selector '.spreadsheet--search'
  end
end
