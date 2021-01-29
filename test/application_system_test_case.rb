require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome

  teardown do
    errors = page.driver.browser.manage.logs.get(:browser)
    if errors.present?
      errors.each do |error|
        assert error.level != 'SEVERE', error.message
        next unless error.level == 'WARNING'

        warn "\e[33mJavaScript warning:"
        warn error.message
      end
    end
  end
end
