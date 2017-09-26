module Edtf
  module Humanize
    module Season

      include Edtf::Humanize::Formats

      def humanize
        "#{apply_if_approximate(self)}"\
        "#{translate_season(self.season)} #{self.year}"\
        "#{apply_if_uncertain(self)}"
      end

      private

      def translate_season(season)
        begin
          I18n.translate!("date.seasons.#{self.season}")
        rescue I18n::MissingTranslationData
          self.season
        end
      end

    end
  end
end
