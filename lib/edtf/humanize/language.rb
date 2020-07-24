# frozen_string_literal: true

module Edtf
  module Humanize
    module Language
      extend self

      def language_strategy
        Edtf::Humanize.configuration.language_strategy(I18n.locale)
      end
    end
  end
end
