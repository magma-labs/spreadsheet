class Spreadsheet::BaseComponent < ViewComponent::Base
  def random_id
    "random_#{(rand * 1000000000000).to_i}"
  end
end