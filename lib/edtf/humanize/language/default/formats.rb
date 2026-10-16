# frozen_string_literal: true

module Edtf
  module Humanize
    module Language
      module Default
        module Formats
          extend self

          private

          def date_format(date)
            "#{apply_prefix_if_uncertain(date)}#{apply_if_unspecified_year(date)}#{apply_suffix_if_uncertain(date)}"
          end

          def date_precision(date)
            if date.respond_to? :precision
              case date.precision
              when :day # 2010-10-25
                day_precision_format(date)
              when :month # 2010-10
                month_precision_format(date)
              when :year # 2010
                year_precision_format(date)
              end
            else
              date
            end
          end

          # October 5, 1995
          def day_precision_format(date)
            I18n.localize(
              date,
              format: I18n.t('edtf.formats.day_precision_strftime_format',
                             default: '%B %-d, %Y')
            )
          end

          # October 1995
          def month_precision_format(date)
            I18n.localize(
              date,
              format: I18n.t('edtf.formats.month_precision_strftime_format',
                             default: '%B %Y')
            )
          end

          # 1995
          def year_precision_format(date)
            date.strftime(I18n.t('edtf.formats.year_precision_strftime_format',
                                 default: '%Y'))
          end

          # '1990~' => circa 1990
          def apply_prefix_if_approximate(date)
            return unless date.respond_to?(:approximate?) && date.approximate?

            case date.precision
            when :year
              I18n.t('edtf.terms.approximate_date_prefix_year',
                     default: 'circa ')
            when :month
              I18n.t('edtf.terms.approximate_date_prefix_month',
                     default: 'circa ')
            when :day
              I18n.t('edtf.terms.approximate_date_prefix_day',
                     default: 'circa ')
            end
          end

          # '1990~' => 1990 environ
          def apply_suffix_if_approximate(date)
            return '' unless date.respond_to?(:approximate?) &&
                             date.approximate?

            case date.precision
            when :year
              I18n.t('edtf.terms.approximate_date_suffix_year', default: '')
            when :month
              I18n.t('edtf.terms.approximate_date_suffix_month', default: '')
            when :day
              I18n.t('edtf.terms.approximate_date_suffix_day', default: '')
            end
          end

          # '1990?' => 1990?
          def apply_suffix_if_uncertain(date)
            return '' unless date.respond_to?(:uncertain?) && date.uncertain?

            I18n.t('edtf.terms.uncertain_date_suffix', default: '?')
          end

          # '1990?' => ?1990
          def apply_prefix_if_uncertain(date)
            return '' unless date.respond_to?(:uncertain?) && date.uncertain?

            I18n.t('edtf.terms.uncertain_date_prefix', default: '')
          end

          # '198X' => 1980s (year unknown), '198X-05' => May 198X
          def apply_if_unspecified_year(date)
            display = date_precision(date)
            if date.respond_to?(:unspecified?) && (date.unspecified? :year)
              unspecified_span = unspecified_year_span(date)
              return unspecified_span if unspecified_span

              year_substitute =
                date.year_precision.edtf.gsub(
                  'u',
                  I18n.t('edtf.terms.unspecified_digit_substitute',
                         default: 'x')
                )
              # Match the zero-padded year as formatted, not year.to_s, which
              # mismatches for years 0-999 and negative years ('00XX', '-01XX')
              display.sub!(date.strftime('%Y'), year_substitute)
            end
            display
          end

          # A year with unspecified trailing digits is one unknown year
          # within a decade or century, not the whole span
          def unspecified_year_span(date)
            return unless date.precision == :year

            case date.unspecified.year.map { |digit| digit == true }
            when [false, false, false, true] then unspecified_year_in_decade(date)
            when [false, false, true, true] then unspecified_year_in_century(date)
            end
          end

          # '198X' => 1980s (year unknown)
          def unspecified_year_in_decade(date)
            strategy = Edtf::Humanize::Language.language_strategy
            decade = strategy::Decade.humanizer(EDTF::Decade.new(date.year))
            I18n.t('edtf.terms.unspecified_year_in_decade',
                   decade: decade,
                   default: "#{decade} (year unknown)")
          end

          # '19XX' => 20th century (year unknown)
          def unspecified_year_in_century(date)
            strategy = Edtf::Humanize::Language.language_strategy
            century = strategy::Century.humanizer(EDTF::Century.new(date.year))
            I18n.t('edtf.terms.unspecified_year_in_century',
                   century: century,
                   default: "#{century} (year unknown)")
          end
        end
      end
    end
  end
end
