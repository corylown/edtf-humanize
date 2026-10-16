# frozen_string_literal: true

module Edtf
  module Humanize
    module Language
      module_function

      # Public as Language.language_strategy, private when mixed into
      # Date and the EDTF classes
      def language_strategy
        Edtf::Humanize.configuration.language_strategy(I18n.locale)
      end
    end
  end
end
