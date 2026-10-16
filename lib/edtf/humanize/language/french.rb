# frozen_string_literal: true

module Edtf
  module Humanize
    module Language
      module French
        include Default

        module Century
          extend self

          def humanizer(date)
            "#{RomanNumerals.to_roman((date.year.abs / 100) + 1)}" \
              "#{century_number_suffix(date)}" \
              "#{century_sign_suffix(date)}"
          end

          private

          def century_number_suffix(date)
            return 'er siècle' if (date.year.abs / 100).zero?

            'e siècle'
          end

          def century_sign_suffix(date)
            return ' avant J.C.' if date.year.negative?

            ''
          end
        end

        # Decade and century endpoints contract the article with the
        # preposition: '198X/199X' => Des années 1980 aux années 1990
        module Interval
          include Default::Interval

          extend self

          def humanizer(date)
            return super unless [date.from, date.to].all?(::Date)
            return super unless span_endpoint?(date.from) || span_endpoint?(date.to)

            "#{from_phrase(date)}#{to_phrase(date)}"
          end

          private

          def from_phrase(date)
            span_phrase(date.from, decade: 'Des années', century: 'Du') ||
              "#{interval_prefix(date)}#{formatted_date(date.from)}"
          end

          def to_phrase(date)
            span = span_phrase(date.to, decade: 'aux années', century: 'au')
            span ? " #{span}" : "#{interval_connector(date)}#{formatted_date(date.to)}"
          end

          # Des années 1980 (année inconnue), au XXIe siècle (année inconnue)
          def span_phrase(endpoint, decade:, century:)
            phrase = case span_kind(endpoint)
                     when :decade then "#{decade} #{decade_years(endpoint)}"
                     when :century then "#{century} #{Century.humanizer(EDTF::Century.new(endpoint.year))}"
                     end
            annotate_unknown_parts(phrase, unknown_parts(endpoint)) if phrase
          end

          # Only year-precision endpoints; '198X-05' keeps the default wording
          def span_endpoint?(endpoint)
            endpoint.is_a?(::Date) && endpoint.unspecified?(:year) &&
              known_precision(endpoint) == :year && !unspecified_year_kind(endpoint).nil?
          end

          def span_kind(endpoint)
            unspecified_year_kind(endpoint) if span_endpoint?(endpoint)
          end

          def decade_years(endpoint)
            return endpoint.year.to_s unless endpoint.year.negative?

            "#{endpoint.year.abs}#{I18n.t('edtf.terms.bc_suffix', default: ' avant J.C.')}"
          end
        end
      end
    end
  end
end
