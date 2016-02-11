module Edtf
  module Humanize
    module Decade

      include Edtf::Humanize::Formats
    
      def humanize
        "#{self.begin.year}s"
      end

    end
  end
end
