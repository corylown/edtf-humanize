module Edtf
  module Humanize
    module Unknown
      
      include Edtf::Humanize::Strategies

      def basic_humanize
        Edtf::Humanize.configuration.unknown
      end

    end
  end
end