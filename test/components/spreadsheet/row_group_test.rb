require "test_helper"

class RowGroupTest < ViewComponent::TestCase
  def test_render_component
    render_inline(::Spreadsheet::RowGroup.new(id: 'row-group-test'))

    assert_selector("div.spreadsheet--row-group-container")
    assert_selector("div.spreadsheet--row-group")
    assert_selector("div.row_group-header")
    assert_selector("div.row_group-body")
  end
end
