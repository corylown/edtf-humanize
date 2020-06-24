# frozen_string_literal: true
module Edtf
  module Humanize
    module Set

      include Edtf::Humanize::Formats
      include Edtf::Humanize::Strategies

      def basic_humanize
        mode = choice? ? 'exclusive' : 'inclusive'
        format_set_entries(self).to_sentence(
            words_connector: I18n.t("edtf.terms.set_dates_connector_#{mode}"),
            last_word_connector: I18n.t("edtf.terms.set_last_date_connector_#{mode}"),
            two_words_connector: I18n.t("edtf.terms.set_two_dates_connector_#{mode}")
          )
      end

      private

      def format_set_entries(dates)
        dates.entries.map.with_index do |date, index|
          "#{apply_if_earlier(dates, index)}"\
          "#{apply_if_later(dates, index)}"\
          "#{apply_prefix_if_approximate(date)}"\
          "#{date_format(date)}"\
          "#{apply_suffix_if_approximate(date)}"\
        end
      end

      # '[..1760-12-03]' => on or before December 3, 1760
      def apply_if_earlier(dates, index)
        Edtf::Humanize.configuration.set_earlier_prefix if dates.earlier? && index == 0
      end

      # '[1760-12..]' => on or after December 1760
      def apply_if_later(dates, index)
        Edtf::Humanize.configuration.set_later_prefix if dates.later? && (index + 1) == dates.size
      end

    end
  end
end
