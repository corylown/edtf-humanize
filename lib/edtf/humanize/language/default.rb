# frozen_string_literal: true

module Edtf
  module Humanize
    module Language
      module Default
        include Century
        include Decade
        include Interval
        include IsoDate
        include Season
        include Set
        include Unknown
      end
    end
  end
end
