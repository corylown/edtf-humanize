# frozen_string_literal: true

module Edtf
  module Humanize
    module Language
      module Default
        module Decade
          include Edtf::Humanize::Language::Default::Formats

          extend self

          # '199x' => 1990s, '-001x' => 10s BCE
          def humanizer(date)
            "#{I18n.t('edtf.terms.decade_prefix', default: '')}" \
              "#{date.begin.year.abs}" \
              "#{I18n.t('edtf.terms.decade_suffix', default: 's')}" \
              "#{bc_suffix(date)}"
          end

          private

          def bc_suffix(date)
            return '' unless date.begin.year.negative?

            I18n.t('edtf.terms.bc_suffix', default: ' BCE')
          end
        end
      end
    end
  end
end
