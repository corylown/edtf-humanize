# frozen_string_literal: true

module Edtf
  module Humanize
    module Language
      module Default
        module Season
          include Edtf::Humanize::Language::Default::Formats

          extend self

          def humanizer(date)
            "#{apply_prefix_if_uncertain(date)}" \
              "#{apply_prefix_if_approximate(date)}" \
              "#{translate_season(date.season)} #{date.year}" \
              "#{apply_suffix_if_approximate(date)}" \
              "#{apply_suffix_if_uncertain(date)}"
          end

          private

          # EDTF::Season has no precision, so use the year-precision terms
          # '1999-21~' => circa spring 1999
          def apply_prefix_if_approximate(date)
            return '' unless date.approximate?

            I18n.t('edtf.terms.approximate_date_prefix_year', default: 'circa ')
          end

          # '1999-21~' => printemps 1999 environ
          def apply_suffix_if_approximate(date)
            return '' unless date.approximate?

            I18n.t('edtf.terms.approximate_date_suffix_year', default: '')
          end

          def translate_season(season)
            I18n.translate!("date.seasons.#{season}")
          rescue I18n::MissingTranslationData
            season
          end
        end
      end
    end
  end
end
