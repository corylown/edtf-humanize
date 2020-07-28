# frozen_string_literal: true

module Edtf
  module Humanize
    module IsoDate
      include Edtf::Humanize::Language

      def humanize
        language_strategy::IsoDate.humanizer(self)
      end
    end
  end
end
