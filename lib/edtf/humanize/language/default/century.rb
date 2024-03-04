# frozen_string_literal: true

module Edtf
  module Humanize
    module Language
      module Default
        module Century
          include Edtf::Humanize::Language::Default::Formats

          extend self

          def humanizer(date)
            "#{date.begin.year}" \
              "#{I18n.t('edtf.terms.century_suffix', default: 's')}"
          end
        end
      end
    end
  end
end
