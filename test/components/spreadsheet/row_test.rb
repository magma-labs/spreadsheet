require "test_helper"

class RowTest < ViewComponent::TestCase
  def test_render_component
    render_inline(::Spreadsheet::Row.new(id: 'row-test'))

    assert_selector("div.spreadsheet--row")
  end
end
