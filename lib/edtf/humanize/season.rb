# frozen_string_literal: true

module Edtf
  module Humanize
    module Season
      include Edtf::Humanize::Language

      def humanize
        language_strategy::Season.humanizer(self)
      end
    end
  end
end
