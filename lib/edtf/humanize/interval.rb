module Edtf
  module Humanize
    module Interval

      include Edtf::Humanize::Formats

      def humanize
        "#{apply_if_approximate(self.from)}"\
        "#{simple_date_format(self.from)}"\
        "#{Edtf::Humanize.configuration.interval_connector}"\
        "#{apply_if_approximate(self.to)}"\
        "#{simple_date_format(self.to)}"
      end

      private

      # '198u/199u' => 1980s to 1990s
      def apply_if_unspecified_year date
        display = date_precision(date)
        if date.respond_to? :unspecified?
          if date.unspecified? :year
            display << Edtf::Humanize.configuration.interval_unspecified_suffix
          end
        end
        display
      end

    end
  end
end
