class Spreadsheet::BaseComponent < ViewComponent::Base
  def random_id
    "random_#{(rand * 1000000000000).to_i}"
  end

  def component_controller
    @opts[:controller] || default_component_controller
  end
end
