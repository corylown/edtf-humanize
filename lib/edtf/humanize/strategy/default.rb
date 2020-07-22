module Edtf
  module Humanize
    module Strategy
      class Default
        include Edtf::Humanize::Formats

        def humanize(date)
          date.basic_humanize
        end

        def date_format(date)
          simple_date_format(date)
        end

        def open_interval(formatted_date:, type:, precision:)
          case type
          when :start
            open_start_interval(formatted_date: formatted_date, precision: precision)
          when :end
            open_end_interval(formatted_date: formatted_date, precision: precision)
          end
        end

      end
    end
  end
end