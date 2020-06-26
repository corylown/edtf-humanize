module Edtf
  module Humanize
    module Interval
      include Edtf::Humanize::Formats
      include Edtf::Humanize::Strategies

      def basic_humanize
        output = ''
        if from == :open
          output << (open_interval(formatted_date: formatted_date(to), type: :start, precision: to.precision) || '')
        elsif to == :open
          output << (open_interval(formatted_date: formatted_date(from), type: :end, precision: from.precision) || '')
        else
          output << (interval_prefix || '')
          output << formatted_date(from)
          output << (interval_connector || '')
          output << formatted_date(to)
        end
      end

      private

      def formatted_date(date)
        (apply_prefix_if_approximate(date) || '') << (date_format(date) || '') << (apply_suffix_if_approximate(date) || '')
      end

      def interval_prefix
        case from.precision
        when :year
          I18n.t('edtf.terms.interval_prefix_year')
        when :month
          I18n.t('edtf.terms.interval_prefix_month')
        when :day
          I18n.t('edtf.terms.interval_prefix_day')
        end
      end

      def interval_connector
        return I18n.t('edtf.terms.interval_connector_open').to_s if to == :open

        if to.approximate.day || to.approximate.month || to.approximate.year
          return I18n.t('edtf.terms.interval_connector_approximate').to_s
        end

        case to.precision
        when :year
          I18n.t('edtf.terms.interval_connector_year')
        when :month
          I18n.t('edtf.terms.interval_connector_month')
        when :day
          I18n.t('edtf.terms.interval_connector_day')
        end
      end

      # '198u/199u' => 1980s to 1990s
      def apply_if_unspecified_year(date)
        display = date_precision(date)
        if date.respond_to? :unspecified?
          display << Edtf::Humanize.configuration.interval_unspecified_suffix if date.unspecified? :year
        end
        display
      end
    end
  end
end
