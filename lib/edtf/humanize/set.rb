module Edtf
  module Humanize
    module Set

      include Edtf::Humanize::Formats

      def humanize
        format_set_entries(self).to_sentence(
          words_connector:     Edtf::Humanize.configuration.set_dates_connector,
          last_word_connector: Edtf::Humanize.configuration.set_last_date_connector,
          two_words_connector: Edtf::Humanize.configuration.set_two_dates_connector
        )
      end

      private

      def format_set_entries(dates)
        dates.entries.map { |date| "#{apply_if_approximate(date)}#{simple_date_format(date)}" }
      end

    end
  end
end
