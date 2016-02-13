module Edtf
  module Humanize

    require 'edtf'

    require 'edtf/humanize/formats'
    require 'edtf/humanize/decade'
    require 'edtf/humanize/century'
    require 'edtf/humanize/season'
    require 'edtf/humanize/interval'
    require 'edtf/humanize/set'
    require 'edtf/humanize/iso_date'

    EDTF::Decade.include Edtf::Humanize::Decade
    EDTF::Century.include Edtf::Humanize::Century
    EDTF::Season.include Edtf::Humanize::Season
    EDTF::Interval.include Edtf::Humanize::Interval
    EDTF::Set.include Edtf::Humanize::Set
    Date.include Edtf::Humanize::IsoDate

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.configuration=(configuration)
      @configuration = configuration
    end

    def self.configure
      yield configuration
    end

    class Configuration

      attr_accessor :day_precision_strftime_format,
                    :month_precision_strftime_format,
                    :year_precision_strftime_format,
                    :approximate_date_prefix,
                    :uncertain_date_suffix,
                    :decade_suffix,
                    :century_suffix,
                    :unspecified_digit_substitute,
                    :interval_connector,
                    :set_dates_connector,
                    :set_last_date_connector,
                    :set_two_dates_connector,
                    :interval_unspecified_suffix

      def initialize
        @day_precision_strftime_format = "%B %-d, %Y"
        @month_precision_strftime_format = "%B %Y"
        @year_precision_strftime_format = "%Y"

        @approximate_date_prefix = "circa "
        
        @uncertain_date_suffix = "?"
        
        @decade_suffix = "s"
        @century_suffix = "s"
        
        @unspecified_digit_substitute = "x"

        @interval_connector = " to "
        @interval_unspecified_suffix = "s"

        @set_dates_connector = ", "
        @set_last_date_connector = " or "
        @set_two_dates_connector = " or "
      end

    end
   
  end
end
