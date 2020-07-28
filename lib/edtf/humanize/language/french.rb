# frozen_string_literal: true

module Edtf
  module Humanize
    module Language
      module French
        include Default

        module Century
          extend self

          def humanizer(date)
            require 'roman'
            "#{(date.year.abs / 100 + 1).to_roman}" \
            "#{century_number_suffix(date)}" \
            "#{century_sign_suffix(date)}"
          end

          private

          def century_number_suffix(date)
            return 'er siècle' if (date.year.abs / 100).zero?

            'e siècle'
          end

          def century_sign_suffix(date)
            return ' avant J.C.' if date.year.negative?

            ''
          end
        end
      end
    end
  end
end
