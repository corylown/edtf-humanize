module Edtf
  module Humanize
    module Interval

      include Edtf::Humanize::Formats
      include Edtf::Humanize::Strategies

      def basic_humanize
        output = ""
        if self.from == :open
          output << (open_interval(formatted_date: formatted_date(self.to), type: :start, precision: self.to.precision) || "")
        elsif self.to == :open
          output << (open_interval(formatted_date: formatted_date(self.from), type: :end, precision: self.from.precision) || "")
        else
          output << (interval_prefix || "")
          output << formatted_date(self.from)
          output << (interval_connector || "")
          output << formatted_date(self.to)
        end

      end

      private

      def formatted_date(date)
        (apply_prefix_if_approximate(date) || "") << (date_format(date) || "") << (apply_suffix_if_approximate(date) || "")
      end

      def interval_prefix
        case self.from.precision
        when :year
          I18n.t("edtf.terms.interval_prefix_year")
        when :month
          I18n.t("edtf.terms.interval_prefix_month")
        when :day
          I18n.t("edtf.terms.interval_prefix_day")
        end
      end

      def interval_connector
        return "#{I18n.t("edtf.terms.interval_connector_open")}" if self.to == :open
        return "#{I18n.t("edtf.terms.interval_connector_approximate")}" if (self.to.approximate.day || self.to.approximate.month || self.to.approximate.year)
        case self.to.precision
        when :year
          I18n.t("edtf.terms.interval_connector_year")
        when :month
          I18n.t("edtf.terms.interval_connector_month")
        when :day
          I18n.t("edtf.terms.interval_connector_day")
        end
      end

      # '198u/199u' => 1980s to 1990s
      def apply_if_unspecified_year date
        display = date_precision(date)
        if date.respond_to? :unspecified?
          if date.unspecified? :year
            display << Edtf::Humanize.configuration.interval_unspecified_suffix
          end
        end
        display
      end

    end
  end
end
