module Edtf
  module Humanize
    module Unknown
      include Edtf::Humanize::Strategies

      def basic_humanize
        I18n.t('edtf.terms.unknown')
      end
    end
  end
end
