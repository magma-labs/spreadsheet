module Spreadsheet
  class Header < Row
    attr_reader :columns
    attr_reader :locked

    with_content_areas :context_menu

    def initialize(id:, columns:, labels: {}, colspans: {}, classnames: {}, locked: {}, **opts)
      super
      @columns = columns.map(&:to_sym)
      @colspans = colspans
      @classnames = classnames
      @locked = locked.map(&:to_sym)
      @labels = labels
    end

    def classnames_for(id)
      [@classnames[:all], @classnames[id]].compact.join(" ")
    end

    def colspan_for(id)
      @colspans[id] || 1
    end

    def label_for(id)
      @labels[id] || id.to_s.titleize
    end
  end
end