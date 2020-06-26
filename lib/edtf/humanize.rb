module Edtf
  module Humanize

    require 'edtf'

    require 'edtf/humanize/formats'
    require 'edtf/humanize/strategies'
    require 'edtf/humanize/decade'
    require 'edtf/humanize/century'
    require 'edtf/humanize/season'
    require 'edtf/humanize/interval'
    require 'edtf/humanize/set'
    require 'edtf/humanize/unknown'
    require 'edtf/humanize/iso_date'
    require 'edtf/humanize/strategy/default'
    require 'edtf/humanize/strategy/french'
    require 'edtf/humanize/strategy/english'

    EDTF::Decade.include Edtf::Humanize::Decade
    EDTF::Century.include Edtf::Humanize::Century
    EDTF::Season.include Edtf::Humanize::Season
    EDTF::Interval.include Edtf::Humanize::Interval
    EDTF::Set.include Edtf::Humanize::Set
    EDTF::Unknown.include Edtf::Humanize::Unknown
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
      attr_accessor :unspecified_digit_substitute,
                    :interval_unspecified_suffix,
                    :set_earlier_prefix,
                    :set_later_prefix,
                    :unknown

      def initialize
        @language_strategies = {
            default: Edtf::Humanize::Strategy::Default,
            en: Edtf::Humanize::Strategy::English,
            fr: Edtf::Humanize::Strategy::French,
        }

        @unspecified_digit_substitute = 'x'

        @interval_unspecified_suffix = 's'

        @set_dates_connector = ', '
        @set_earlier_prefix = 'on or before '
        @set_later_prefix = 'on or after '

        @unknown = 'unknown'
      end

      def set_language_strategy(language, strategy)
        raise "Language strategy for #{language} should be a class" unless strategy.class == Class
        raise "Language strategy for #{language} should define 'humanize' method" unless strategy.instance_methods.contains(:humanize)
        @language_strategies[language.to_sym] = strategy
      end

      def language_strategy(language)
        @language_strategies[language.to_sym] || language_strategies[:default]
      end
    end

  end
end
