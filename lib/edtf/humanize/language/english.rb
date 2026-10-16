# frozen_string_literal: true

require 'active_support/core_ext/integer/inflections'

module Edtf
  module Humanize
    module Language
      module English
        include Default

        module Century
          extend self

          # '19xx' => 20th century, '-01xx' => 2nd century BCE
          def humanizer(date)
            "#{century_number(date)} century" \
              "#{century_sign_suffix(date)}"
          end

          private

          def century_number(date)
            I18n.with_locale(:en) { ((date.year.abs / 100) + 1).ordinalize }
          end

          def century_sign_suffix(date)
            return ' BCE' if date.year.negative?

            ''
          end
        end
      end
    end
  end
end
