# frozen_string_literal: true

module Edtf
  module Humanize
    module Language
      module Default
        module Decade
          include Edtf::Humanize::Language::Default::Formats

          extend self

          def humanizer(date)
            "#{I18n.t('edtf.terms.decade_prefix', default: '')}" \
            "#{date.begin.year}" \
            "#{I18n.t('edtf.terms.decade_suffix', default: 's')}"
          end
        end
      end
    end
  end
end
