module Edtf
  module Humanize
    module Formats

      private

      def simple_date_format date
        "#{apply_if_unspecified_year(date)}#{apply_if_uncertain(date)}"
      end

      def date_precision date
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
      def day_precision_format date
        I18n.localize(date, format: I18n.t("edtf.formats.day_precision_strftime_format"))
      end

      # October 1995
      def month_precision_format date
        I18n.localize(date, format: I18n.t("edtf.formats.month_precision_strftime_format"))
      end

      # 1995
      def year_precision_format date
        date.strftime(I18n.t("edtf.formats.year_precision_strftime_format"))
      end

      # '1990~' => circa 1990
      def apply_prefix_if_approximate date
        if date.respond_to? :approximate?
          if date.approximate?
            case date.precision
            when :year
              "#{I18n.t("edtf.terms.approximate_date_prefix_year")}"
            when :month
              "#{I18n.t("edtf.terms.approximate_date_prefix_month")}"
            when :day
              "#{I18n.t("edtf.terms.approximate_date_prefix_day")}"
            end
          end
        end
      end

      # '1990~' => 1990 environ
      def apply_suffix_if_approximate date
        if date.respond_to? :approximate?
          if date.approximate?
            case date.precision
            when :year
              "#{I18n.t("edtf.terms.approximate_date_suffix_year")}"
            when :month
              "#{I18n.t("edtf.terms.approximate_date_suffix_month")}"
            when :day
              "#{I18n.t("edtf.terms.approximate_date_suffix_day")}"
            end
          end
        end
      end

      # '1990?' => 1990?
      def apply_if_uncertain date
        if date.respond_to? :uncertain?
          if date.uncertain?
            I18n.t("edtf.terms.uncertain_date_suffix")
          end
        end
      end

      # '198u' => 198x
      def apply_if_unspecified_year date
        display = date_precision(date)
        if date.respond_to? :unspecified?
          if date.unspecified? :year
            year_substitute = date.year_precision.edtf.gsub(/u/, Edtf::Humanize.configuration.unspecified_digit_substitute)
            display.gsub!("#{date.year}", year_substitute)
          end
          elsif date
        end
        display
      end

      # open/1980 => Jusqu'en 1980
      def open_start_interval(formatted_date:, precision:)
        case date.precision
        when :year
          "#{I18n.t("edtf.terms.open_start_interval_with_year", date: formatted_date)}"
        when :month
          "#{I18n.t("edtf.terms.open_start_interval_with_month", date: formatted_date)}"
        when :day
          "#{I18n.t("edtf.terms.open_start_interval_with_day", date: formatted_date)}"
        end
      end

      # 1980/open => Depuis 1980
      def open_end_interval(formatted_date:, precision:)
        case precision
        when :year
          "#{I18n.t("edtf.terms.open_end_interval_with_year", date: formatted_date)}"
        when :month
          "#{I18n.t("edtf.terms.open_end_interval_with_month", date: formatted_date)}"
        when :day
          "#{I18n.t("edtf.terms.open_end_interval_with_day", date: formatted_date)}"
        end
      end

    end
  end
end