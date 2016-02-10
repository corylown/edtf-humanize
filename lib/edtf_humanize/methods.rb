module EdtfHumanize
  module Methods

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
      date.strftime('%B %d, %Y')
    end

    # October 1995
    def month_precision_format date
      date.strftime('%B %Y')
    end
    
    # 1995
    def year_precision_format date
      date.strftime('%Y')
    end

    # '1990~' => circa 1990
    def apply_if_approximate date
      if date.respond_to? :approximate?
        if date.approximate?
          "circa "
        end
      end
    end

    # '1990?' => 1990?
    def apply_if_uncertain date
      if date.respond_to? :uncertain?
        if date.uncertain?
          "?"
        end
      end
    end

    # '198u' => 198x
    def apply_if_unspecified_year date
      display = date_precision(date)
      if date.respond_to? :unspecified?
        if date.unspecified? :year
          year_substitute = date.year_precision.edtf.gsub(/u/, 'x')
          display.gsub!("#{date.year}", year_substitute)
        end
      end
      display
    end

  end
end
