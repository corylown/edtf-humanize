module Edtf
  module Humanize
    module Interval

      include Edtf::Humanize::Formats

      def humanize
        "#{apply_if_approximate(self.from)}#{simple_date_format(self.from)} to #{simple_date_format(self.to)}"
      end

      private

      # '198u/199u' => 1980s to 1990s
      def apply_if_unspecified_year date
        display = date_precision(date)
        if date.respond_to? :unspecified?
          if date.unspecified? :year
            display << "s"
          end
        end
        display
      end

    end
  end
end
