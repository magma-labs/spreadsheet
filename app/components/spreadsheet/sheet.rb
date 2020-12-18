class Spreadsheet::Sheet < ViewComponent::Base

  def initialize(opts = {})
    RequestStore.store[:row_parent] = self
    @classnames = opts[:classnames] || {}
    @opts = opts
  end

  def level
    0
  end

  def data
    {
      controller: component_controller,
      action: component_actions
    }
  end

  def component_controller
    @opts[:controller] || "spreadsheet--sheet"
  end

  def component_classnames
    @classnames
  end

  private

  def component_actions
    [
      "dragstart@document->#{component_controller}#startSum",
      "dragenter@document->#{component_controller}#calculateSum"
    ].join(" ")
  end
end
