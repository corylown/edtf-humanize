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
