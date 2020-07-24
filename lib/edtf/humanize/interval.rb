# frozen_string_literal: true

module Edtf
  module Humanize
    module Interval
      include Edtf::Humanize::Language

      def humanize
        language_strategy::Interval.humanizer(self)
      end
    end
  end
end
