# frozen_string_literal: true

require 'test_helper'

class RowTest < ViewComponent::TestCase
  def test_render_component
    render_inline(::Spreadsheet::Row.new(id: 'row-test'))

    assert_selector('div.spreadsheet--row')
  end

  def test_selectable
    render_inline(::Spreadsheet::Row.new(id: 'row-test', selectable: true))
    assert_selector('.row-checkbox')
    assert_selector('.row_actionmenu')
  end

  def test_draghandle
    render_inline(::Spreadsheet::Row.new(id: 'row-test', draghandle: true))
    assert_selector('.draghandle')
  end

  def test_actions_menu
    render_inline(::Spreadsheet::Row.new(id: 'row-test')) do |component|
      component.with(:actions_menu, 'Row Menu')
    end
    assert_selector('.row_actionmenu')
    assert_selector('sl-menu', text: 'Row Menu')
  end
end
