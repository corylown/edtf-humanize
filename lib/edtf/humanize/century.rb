# frozen_string_literal: true

module Edtf
  module Humanize
    module Century
      include Edtf::Humanize::Language

      def humanize
        language_strategy::Century.humanizer(self)
      end
    end
  end
end
