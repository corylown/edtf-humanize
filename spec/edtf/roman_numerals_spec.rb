# frozen_string_literal: true

require 'edtf-humanize'

RSpec.describe Edtf::Humanize::RomanNumerals do
  {
    1 => 'I', 4 => 'IV', 9 => 'IX', 14 => 'XIV', 20 => 'XX', 21 => 'XXI',
    40 => 'XL', 90 => 'XC', 400 => 'CD', 1999 => 'MCMXCIX', 4000 => 'MMMM'
  }.each do |number, roman|
    it "converts #{number} to #{roman}" do
      expect(described_class.to_roman(number)).to eq(roman)
    end
  end

  it 'does not add Integer#to_roman' do
    expect(Integer).not_to be_method_defined(:to_roman)
  end
end
