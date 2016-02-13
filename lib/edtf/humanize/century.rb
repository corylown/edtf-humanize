module Edtf
  module Humanize
    module Century

      include Edtf::Humanize::Formats
    
      def humanize
        "#{self.begin.year}#{Edtf::Humanize.configuration.century_suffix}"
      end

    end
  end
end
