# frozen_string_literal: true

module Edtf
  module Humanize
    require 'edtf'

    require 'edtf/humanize/language'
    require 'edtf/humanize/decade'
    require 'edtf/humanize/century'
    require 'edtf/humanize/season'
    require 'edtf/humanize/interval'
    require 'edtf/humanize/set'
    require 'edtf/humanize/unknown'
    require 'edtf/humanize/iso_date'
    require 'edtf/humanize/language/default/formats'
    require 'edtf/humanize/language/default/decade'
    require 'edtf/humanize/language/default/century'
    require 'edtf/humanize/language/default/season'
    require 'edtf/humanize/language/default/interval'
    require 'edtf/humanize/language/default/set'
    require 'edtf/humanize/language/default/unknown'
    require 'edtf/humanize/language/default/iso_date'
    require 'edtf/humanize/language/default'
    require 'edtf/humanize/language/english'
    require 'edtf/humanize/language/french'

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
      def initialize
        @language_strategies = {
          default: Edtf::Humanize::Language::Default,
          en: Edtf::Humanize::Language::English,
          fr: Edtf::Humanize::Language::French
        }
      end

      def language_strategy(language)
        @language_strategies[language.to_sym] || @language_strategies[:default]
      end
    end
  end
end
