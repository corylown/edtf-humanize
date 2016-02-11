module Edtf
  module Humanize

    require 'edtf'

    require 'edtf/humanize/formats'
    require 'edtf/humanize/decade'
    require 'edtf/humanize/season'
    require 'edtf/humanize/interval'
    require 'edtf/humanize/set'
    require 'edtf/humanize/iso_date'

    EDTF::Decade.include Edtf::Humanize::Decade
    EDTF::Season.include Edtf::Humanize::Season
    EDTF::Interval.include Edtf::Humanize::Interval
    EDTF::Set.include Edtf::Humanize::Set
    Date.include Edtf::Humanize::IsoDate
   
  end
end
