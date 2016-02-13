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
          when :day                     # 2010-10-25
            day_precision_format(date)
          when :month                   # 2010-10
            month_precision_format(date)
          when :year                    # 2010
            year_precision_format(date)
          end
        else
          date
        end
      end

      # October 5, 1995
      def day_precision_format date
        date.strftime(Edtf::Humanize.configuration.day_precision_strftime_format)
      end

      # October 1995
      def month_precision_format date
        date.strftime(Edtf::Humanize.configuration.month_precision_strftime_format)
      end
      
      # 1995
      def year_precision_format date
        date.strftime('%Y')
      end

      # '1990~' => circa 1990
      def apply_if_approximate date
        if date.respond_to? :approximate?
          if date.approximate?
            Edtf::Humanize.configuration.approximate_date_prefix
          end
        end
      end

      # '1990?' => 1990?
      def apply_if_uncertain date
        if date.respond_to? :uncertain?
          if date.uncertain?
            Edtf::Humanize.configuration.uncertain_date_suffix
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
        end
        display
      end

    end
  end
end