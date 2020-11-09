class Spreadsheet::RowGroup < ViewComponent::Base
  attr_reader :id
  attr_reader :opts

  with_content_areas :header, :body

  def initialize(id:, **opts)
    @id = id
    @opts = opts
    @level =
    @row_parent = RequestStore.store[:row_parent]
    RequestStore.store[:row_parent] = self
  end

  def classnames
    CssClassString::Helper.new(id, draggable: @opts[:draggable], collapsed: @opts[:collapsed]).to_s
  end

  def draggable
    opts[:draggable]
  end

  def level
    @row_parent.level + 1
  end

end
