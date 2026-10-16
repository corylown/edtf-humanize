# frozen_string_literal: true

module Edtf
  module Humanize
    # Roman numerals for century names (e.g. French "XXe siècle")
    module RomanNumerals
      NUMERALS = {
        1000 => 'M', 900 => 'CM', 500 => 'D', 400 => 'CD',
        100 => 'C', 90 => 'XC', 50 => 'L', 40 => 'XL',
        10 => 'X', 9 => 'IX', 5 => 'V', 4 => 'IV', 1 => 'I'
      }.freeze

      module_function

      # 1999 => "MCMXCIX"; thousands beyond 3999 repeat M
      def to_roman(number)
        NUMERALS.each_with_object(+'') do |(value, letters), roman|
          count, number = number.divmod(value)
          roman << (letters * count)
        end
      end
    end
  end
end
