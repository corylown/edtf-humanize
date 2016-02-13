module Edtf
  module Humanize
    module Set

      include Edtf::Humanize::Formats

      def humanize
        display = []
        self.entries.each do |date|
          display << "#{apply_if_approximate(date)}#{simple_date_format(date)}"
        end
        display.to_sentence(
          words_connector: Edtf::Humanize.configuration.set_words_connector,
          last_word_connector: Edtf::Humanize.configuration.set_last_word_connector,
          two_words_connector: Edtf::Humanize.configuration.set_two_words_connector
          )
      end

    end
  end
end
