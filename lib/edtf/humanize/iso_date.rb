module Edtf
  module Humanize
    module IsoDate

      include Edtf::Humanize::Formats
      include Edtf::Humanize::Strategies

      def basic_humanize
        "#{apply_if_approximate(self)}#{date_format(self)}"
      end

    end
  end
end
