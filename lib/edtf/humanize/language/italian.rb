# frozen_string_literal: true

module Edtf
  module Humanize
    module Language
      module Italian
        include Default

        module Century
          extend self

          def humanizer(date)
            require 'roman'
            "#{(date.year.abs / 100 + 1).to_roman}" \
            "#{century_number_suffix}" \
            "#{century_sign_suffix(date)}"
          end

          private

          def century_number_suffix
            ' secolo'
          end

          def century_sign_suffix(date)
            return ' a. C.' if date.year.negative?

            ''
          end
        end
      end
    end
  end
end
