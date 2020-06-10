module Edtf
  module Humanize
    module Strategies


      def humanize
        language_strategy.humanize(self)
      end

      def date_format(date)
        language_strategy.date_format(date)
      end

      def language_strategy
        Edtf::Humanize.configuration.language_strategy(I18n.locale).new
      end

    end
  end
end