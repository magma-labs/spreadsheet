class Spreadsheet::Sheet < ViewComponent::Base

  def initialize()
    RequestStore.store[:row_parent] = self
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

  private

  def component_actions
    [
      "dragstart@document->spreadsheet--sheet#startSum",
      "dragenter@document->spreadsheet--sheet#calculateSum"
    ].join(" ")
  end
end
