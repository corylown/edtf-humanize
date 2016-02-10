module EdtfHumanize
  module Set

    include Ddr::Edtf::HumanReadable

    def humanize
      display = []
      self.entries.each do |date|
        display << "#{apply_if_approximate(date)}#{simple_date_format(date)}"
      end
      display.to_sentence(last_word_connector: ' or ', two_words_connector: ' or ')
    end

  end
end
