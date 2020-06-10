module Edtf
  module Humanize
    module Interval

      include Edtf::Humanize::Formats
      include Edtf::Humanize::Strategies

      def basic_humanize
        output = ""
        output << (interval_prefix || "")
        output << (apply_if_approximate(self.from) || "")
        output << (date_format(self.from) || "")
        output << (interval_connector || "")
        output << (apply_if_approximate(self.to) || "")
        output << (date_format(self.to) || "")
      end

      private

      def interval_prefix
        return "#{I18n.t("edtf.terms.interval_prefix_approximate")}" if (self.from.approximate.day || self.from.approximate.month || self.from.approximate.year)
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
