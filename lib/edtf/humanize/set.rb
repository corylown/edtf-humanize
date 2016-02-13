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
          dates_connector: Edtf::Humanize.configuration.set_dates_connector,
          last_date_connector: Edtf::Humanize.configuration.set_last_date_connector,
          two_dates_connector: Edtf::Humanize.configuration.set_two_dates_connector
          )
      end

    end
  end
end
