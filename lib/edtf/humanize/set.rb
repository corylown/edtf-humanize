# frozen_string_literal: true
module Edtf
  module Humanize
    module Set
      include Edtf::Humanize::Formats
      include Edtf::Humanize::Strategies

      def basic_humanize
        format_set_entries(self).to_sentence(
            words_connector: I18n.t("edtf.terms.set_dates_connector_#{mode}", default: ', '),
            last_word_connector: I18n.t("edtf.terms.set_last_date_connector_#{mode}",
                                        default: mode == 'inclusive' ? ' and ' : ' or '),
            two_words_connector: I18n.t("edtf.terms.set_two_dates_connector_#{mode}",
                                        default: mode == 'inclusive' ? ' and ' : ' or ')
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
        if dates.earlier? && index == 0
          I18n.t("edtf.terms.set_earlier_prefix_#{mode}",
                 default: mode == 'inclusive' ? 'on and before ' : 'on or before ')
        end
      end

      # '[1760-12..]' => on or after December 1760
      def apply_if_later(dates, index)
        if dates.later? && (index + 1) == dates.size
          I18n.t("edtf.terms.set_later_prefix_#{mode}",
                 default: mode == 'inclusive' ? 'on and after ' : 'on or after ')
        end
      end

      def mode
        self.choice? ? 'exclusive' : 'inclusive'
      end
    end
  end
end
