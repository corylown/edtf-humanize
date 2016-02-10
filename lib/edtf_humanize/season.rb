module EdtfHumanize
    module Season

      include Ddr::Edtf::HumanReadable

      def humanize
        "#{apply_if_approximate(self)}#{self.season} #{self.year}#{apply_if_uncertain(self)}"
      end

    end
end
