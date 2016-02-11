module Edtf
  module Humanize
    module Season

      include Edtf::Humanize::Formats

      def humanize
        "#{apply_if_approximate(self)}#{self.season} #{self.year}#{apply_if_uncertain(self)}"
      end

    end
  end
end
