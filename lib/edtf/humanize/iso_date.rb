module Edtf
  module Humanize
    module IsoDate

      include Edtf::Humanize::Formats

      def humanize
        "#{apply_if_approximate(self)}#{simple_date_format(self)}"
      end

    end
  end
end
