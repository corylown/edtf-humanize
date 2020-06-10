module Edtf
  module Humanize
    module Decade

      include Edtf::Humanize::Formats
      include Edtf::Humanize::Strategies

      def basic_humanize
        "#{I18n.t("edtf.terms.decade_prefix")}#{self.begin.year}#{I18n.t("edtf.terms.decade_suffix")}"
      end

    end
  end
end
