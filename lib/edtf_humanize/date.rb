module EdtfHumanize
  module Date

    include Ddr::Edtf::Methods

    def humanize
      "#{apply_if_approximate(self)}#{simple_date_format(self)}"
    end

  end
end
