module Edtf
  module Humanize
    module Strategy
      class French < Default

        def humanize(date)
          case date
          when ::EDTF::Century
            format_century(date)
          else
            date.basic_humanize
          end
        end

        def date_format(date)
          case date
          when Century
            format_century(date)
          else
            simple_date_format(date)
          end
        end

        def format_century(date)
          require 'roman'
          "#{(date.year.abs / 100 + 1).to_roman.to_s}" << century_number_suffix(date) << century_sign_suffix(date)
        end

        private

        def century_number_suffix(date)
          if date.year.abs / 100 == 0
            "er siècle"
          else
            "ème siècle"
          end
        end

        def century_sign_suffix(date)
          if date.year < 0
            " avant J.C."
          else
            ""
          end
        end

      end
    end
  end
end
