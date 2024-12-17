# frozen_string_literal: true

module Edtf
  module Humanize
    module Language
      module Default
        module Interval
          include Edtf::Humanize::Language::Default::Formats

          extend self

          def humanizer(date)
            if date.from == :open || date.to == :open
              open_interval(date)
            elsif date.from == :unknown || date.to == :unknown
              unknown_interval(date)
            else
              "#{interval_prefix(date)}" \
                "#{formatted_date(date.from)}" \
                "#{interval_connector(date)}" \
                "#{formatted_date(date.to)}"
            end
          end

          private

          def open_interval(date)
            if date.from == :open
              open_start_interval(formatted_date: formatted_date(date.to),
                                  precision: date.to.precision)
            elsif date.to == :open
              open_end_interval(formatted_date: formatted_date(date.from),
                                precision: date.from.precision)
            end
          end

          # open/1980 => Jusqu'en 1980
          def open_start_interval(formatted_date:, precision:)
            case precision
            when :year
              I18n.t('edtf.terms.open_start_interval_with_year',
                     date: formatted_date,
                     default: "until #{formatted_date}")
            when :month
              I18n.t('edtf.terms.open_start_interval_with_month',
                     date: formatted_date,
                     default: "until #{formatted_date}")
            when :day
              I18n.t('edtf.terms.open_start_interval_with_day',
                     date: formatted_date,
                     default: "until #{formatted_date}")
            end
          end

          # 1980/open => Depuis 1980
          def open_end_interval(formatted_date:, precision:)
            case precision
            when :year
              I18n.t('edtf.terms.open_end_interval_with_year',
                     date: formatted_date,
                     default: "since #{formatted_date}")
            when :month
              I18n.t('edtf.terms.open_end_interval_with_month',
                     date: formatted_date,
                     default: "since #{formatted_date}")
            when :day
              I18n.t('edtf.terms.open_end_interval_with_day',
                     date: formatted_date,
                     default: "since #{formatted_date}")
            end
          end

          def unknown_interval(date)
            if date.from == :unknown
              unknown_start_interval(formatted_date: formatted_date(date.to),
                                     precision: date.to.precision)
            elsif date.to == :unknown
              unknown_end_interval(formatted_date: formatted_date(date.from),
                                   precision: date.from.precision)
            end
          end

          # unknown/1980 => unknown year to 1980
          def unknown_start_interval(formatted_date:, precision:)
            case precision
            when :year
              I18n.t('edtf.terms.unknown_start_interval_with_year',
                     date: formatted_date,
                     default: "unknown date to #{formatted_date}")
            when :month
              I18n.t('edtf.terms.unknown_start_interval_with_month',
                     date: formatted_date,
                     default: "unknown date to #{formatted_date}")
            when :day
              I18n.t('edtf.terms.unknown_start_interval_with_day',
                     date: formatted_date,
                     default: "unknown date to #{formatted_date}")
            end
          end

          # 1980/unknown => 1980 to unknown year
          def unknown_end_interval(formatted_date:, precision:)
            case precision
            when :year
              I18n.t('edtf.terms.unknown_end_interval_with_year',
                     date: formatted_date,
                     default: "#{formatted_date} to unknown date")
            when :month
              I18n.t('edtf.terms.unknown_end_interval_with_month',
                     date: formatted_date,
                     default: "#{formatted_date} to unknown date")
            when :day
              I18n.t('edtf.terms.unknown_end_interval_with_day',
                     date: formatted_date,
                     default: "#{formatted_date} to unknown date")
            end
          end

          def formatted_date(date)
            "#{apply_prefix_if_approximate(date)}" \
              "#{date_format(date)}" \
              "#{apply_suffix_if_approximate(date)}"
          end

          def interval_prefix(date)
            case date.from.precision
            when :year
              I18n.t('edtf.terms.interval_prefix_year', default: '')
            when :month
              I18n.t('edtf.terms.interval_prefix_month', default: '')
            when :day
              I18n.t('edtf.terms.interval_prefix_day', default: '')
            end
          end

          def interval_connector(date)
            return interval_connector_approx if date.to.approximate.day ||
                                                date.to.approximate.month ||
                                                date.to.approximate.year

            interval_connector_other(date)
          end

          def interval_connector_approx
            I18n.t('edtf.terms.interval_connector_approximate',
                   default: ' to ')
          end

          def interval_connector_other(date)
            case date.to.precision
            when :year
              I18n.t('edtf.terms.interval_connector_year', default: ' to ')
            when :month
              I18n.t('edtf.terms.interval_connector_month', default: ' to ')
            when :day
              I18n.t('edtf.terms.interval_connector_day', default: ' to ')
            end
          end

          # '198u/199u' => 1980s to 1990s
          def apply_if_unspecified_year(date)
            if date.respond_to?(:unspecified?) && date.unspecified?(:year)
              return "#{date_precision(date)}" \
                     "#{I18n.t('edtf.terms.interval_unspecified_suffix',
                               default: 's')}"
            end

            date_precision(date)
          end
        end
      end
    end
  end
end
