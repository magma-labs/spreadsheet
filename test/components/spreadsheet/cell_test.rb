require "test_helper"

class CellTest < ViewComponent::TestCase
  def test_render_component
    render_inline(::Spreadsheet::Cell.new(id: 'cell-test'))

    assert_selector("div.spreadsheet--cell")
  end

  def test_expander
    render_inline(::Spreadsheet::Cell.new(id: 'cell-test', expander: true))

    assert_selector("sl-icon.collapse-control")
  end
end
