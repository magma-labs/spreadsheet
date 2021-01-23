# frozen_string_literal: true

require 'test_helper'

class HeaderTest < ViewComponent::TestCase
  def test_render_component
    render_inline(::Spreadsheet::Header.new(
                    id: 'header-test',
                    columns: %i[column0 column1 column2]
                  ))

    assert_selector('div.spreadsheet--header')
  end

  def test_dropdown
    render_inline(::Spreadsheet::Header.new(
                    id: 'header-test',
                    columns: %i[column0 column1 column2]
                  )) do |component|
      component.with(:context_menu, 'Header Menu')
    end

    assert_selector('sl-dropdown', text: 'Header Menu')
  end

  def test_search
    render_inline(::Spreadsheet::Header.new(
                    id: 'header-test',
                    columns: %i[column0 column1 column2]
                  ))

    assert_selector('div.spreadsheet--search')
  end
end
