# frozen_string_literal: true

module Edtf
  module Humanize
    module Language
      module Default
        module IsoDate
          include Edtf::Humanize::Language::Default::Formats

          extend self

          def humanizer(date)
            "#{apply_prefix_if_approximate(date)}" \
            "#{date_format(date)}" \
            "#{apply_suffix_if_approximate(date)}"
          end
        end
      end
    end
  end
end
