module Edtf
  module Humanize
    module IsoDate

      include Edtf::Humanize::Formats
      include Edtf::Humanize::Strategies

      def basic_humanize
        "#{apply_prefix_if_approximate(self)}#{date_format(self)}#{apply_suffix_if_approximate(self)}"
      end

    end
  end
end
