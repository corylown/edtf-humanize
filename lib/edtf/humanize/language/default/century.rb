# frozen_string_literal: true

module Edtf
  module Humanize
    module Language
      module Default
        module Century
          include Edtf::Humanize::Language::Default::Formats

          extend self

          # '19xx' => 1900s, '-01xx' => 100s BCE
          def humanizer(date)
            "#{date.begin.year.abs}" \
              "#{I18n.t('edtf.terms.century_suffix', default: 's')}" \
              "#{bc_suffix(date)}"
          end
        end
      end
    end
  end
end
