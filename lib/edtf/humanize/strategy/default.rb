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
      end
    end
  end
end