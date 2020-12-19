require "test_helper"

class CellTest < ViewComponent::TestCase
  def test_render_component
    render_inline(::Spreadsheet::Cell.new(id: 'cell-test'))

    assert_selector('div.spreadsheet--cell')
  end

  def test_expander
    render_inline(::Spreadsheet::Cell.new(id: 'cell-test', expander: true))

    assert_selector(".collapse-control")
  end

  def test_renders_actions_menu
    render_inline(::Spreadsheet::Cell.new(id: 'cell-test')) do |component|
      component.with(:actions_menu, 'Menu')
    end
    assert_selector('.cell_actionmenu')
  end

  def test_dont_render_input_when_readonly
    render_inline(::Spreadsheet::Cell.new(id: 'cell-test', readonly: true))
    assert_no_selector('input')

    render_inline(::Spreadsheet::Cell.new(id: 'cell-test'))
    assert_selector('input')
  end

  def test_draggable_when_dragsum
    render_inline(::Spreadsheet::Cell.new(id: 'cell-test', dragsum: true))
    assert_selector('.spreadsheet--cell[draggable]')
  end
end
