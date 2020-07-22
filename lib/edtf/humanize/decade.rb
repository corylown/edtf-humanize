module Edtf
  module Humanize
    module Decade
      include Edtf::Humanize::Formats
      include Edtf::Humanize::Strategies

      def basic_humanize
        "#{I18n.t('edtf.terms.decade_prefix', default: '')}" \
        "#{self.begin.year}#{I18n.t('edtf.terms.decade_suffix', default: 's')}"
      end
    end
  end
end
