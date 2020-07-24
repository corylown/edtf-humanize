# frozen_string_literal: true

module Edtf
  module Humanize
    module Set
      include Edtf::Humanize::Language

      def humanize
        language_strategy::Set.humanizer(self)
      end
    end
  end
end
