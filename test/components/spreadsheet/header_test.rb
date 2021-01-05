require 'test_helper'

class HeaderTest < ViewComponent::TestCase
  def test_render_component
    render_inline(::Spreadsheet::Header.new(
      id: 'header-test',
      columns: %i[column0 column1 column2]
    ))

    assert_selector('div.spreadsheet--header')
  end
end
