require "test_helper"

class SheetTest < ViewComponent::TestCase
  def test_render_component
    render_inline(::Spreadsheet::Sheet.new()) { "Ahoy!" }

    assert_selector("div.spreadsheet--sheet", text: "Ahoy!")
  end

  def test_customize_component_controller
    render_inline(::Spreadsheet::Sheet.new())
    assert_selector("div.spreadsheet--sheet[data-controller='spreadsheet--sheet']")

    render_inline(::Spreadsheet::Sheet.new(controller: 'mycustom-controller'))
    assert_selector("div.spreadsheet--sheet[data-controller='mycustom-controller']")
  end
end
