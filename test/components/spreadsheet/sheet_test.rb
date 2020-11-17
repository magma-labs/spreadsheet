require "test_helper"

class SheetTest < ViewComponent::TestCase
  def test_render_component
    render_inline(::Spreadsheet::Sheet.new()) { "Ahoy!" }

    assert_selector("div.spreadsheet--sheet", text: "Ahoy!")
  end
end
