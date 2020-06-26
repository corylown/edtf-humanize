module Edtf
  module Humanize
    module Century
      include Edtf::Humanize::Formats
      include Edtf::Humanize::Strategies

      def basic_humanize
        "#{self.begin.year}#{I18n.t('edtf.terms.century_suffix')}"
      end
    end
  end
end
