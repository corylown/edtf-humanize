# frozen_string_literal: true

module Edtf
  module Humanize
    module Decade
      include Edtf::Humanize::Language

      def humanize
        language_strategy::Decade.humanizer(self)
      end
    end
  end
end
