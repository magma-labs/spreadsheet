class Spreadsheet::Sheet < ViewComponent::Base

  def initialize(opts = {})
    RequestStore.store[:row_parent] = self
    @classnames = opts[:classnames] || {}
  end

  def level
    0
  end

  def data
    {
      controller: "spreadsheet--sheet",
      action: component_actions
    }
  end

  def component_classnames
    @classnames
  end

  private

  def component_actions
    [
      "dragstart@document->spreadsheet--sheet#startSum",
      "dragenter@document->spreadsheet--sheet#calculateSum"
    ].join(" ")
  end
end
