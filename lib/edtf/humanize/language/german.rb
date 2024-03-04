# frozen_string_literal: true

module Edtf
  module Humanize
    module Language
      module German
        include Default

        module Century
          extend self

          def humanizer(date)
            "#{(date.year.abs / 100 + 1)}." \
            "#{century_number_suffix}"
          end

          private

          def century_number_suffix
            ' Jahrhundert'
          end

          def century_sign_suffix(date)
            return ' v. Chr.' if date.year.negative?

            ''
          end
        end
      end
    end
  end
end
