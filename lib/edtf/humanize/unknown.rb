# frozen_string_literal: true

module Edtf
  module Humanize
    module Unknown
      include Edtf::Humanize::Language

      def humanize
        language_strategy::Unknown.humanizer(self)
      end
    end
  end
end
