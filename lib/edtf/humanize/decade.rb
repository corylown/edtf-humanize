module Edtf
  module Humanize
    module Decade

      include Edtf::Humanize::Formats

      def humanize
        "#{self.begin.year}#{Edtf::Humanize.configuration.decade_suffix}"
      end

    end
  end
end
