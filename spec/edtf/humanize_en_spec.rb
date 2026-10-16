# frozen_string_literal: true

require 'edtf-humanize'

RSpec.describe Edtf::Humanize do
  before do
    I18n.locale = :en
  end

  it { is_expected.to be_a(Module) }

  context 'with the language strategy' do
    it 'returns the strategy for the current locale' do
      expect(Edtf::Humanize::Language.language_strategy).to(
        eq(Edtf::Humanize::Language::English)
      )
    end

    it 'is not a public method on humanizable objects' do
      %w[1975-07-01 1975-22 1970/1980 [1667,1668] XXXX 197x 19xx].each do |edtf|
        expect(Date.edtf(edtf)).not_to respond_to(:language_strategy)
      end
    end
  end

  context 'with a decade' do
    it 'returns a humanized decade string' do
      expect(Date.edtf('199x').humanize).to eq('1990s')
    end

    it 'returns a humanized BC decade string' do
      expect(EDTF::Decade.new(-10).humanize).to eq('10s BCE')
    end
  end

  context 'with a century' do
    it 'returns a humanized century string' do
      expect(Date.edtf('19xx').humanize).to eq('20th century')
    end

    it 'returns a humanized first century string' do
      expect(Date.edtf('00xx').humanize).to eq('1st century')
    end

    it 'returns a humanized 11th century string' do
      expect(EDTF::Century.new(1000).humanize).to eq('11th century')
    end

    it 'returns a humanized 21st century string' do
      expect(Date.edtf('20xx').humanize).to eq('21st century')
    end

    it 'returns a humanized BC century string' do
      expect(EDTF::Century.new(-100).humanize).to eq('2nd century BCE')
    end
  end

  context 'with an interval' do
    it 'returns a humanized interval string' do
      expect(Date.edtf('1970/1980').humanize).to eq('1970 to 1980')
    end
  end

  context 'with an open interval' do
    it 'returns a humanized interval string' do
      expect(Date.edtf('1970/open').humanize).to eq('since 1970')
    end
  end

  context 'with an unknown interval start' do
    it 'returns a humanized interval string' do
      expect(Date.edtf('unknown/1970').humanize).to eq('unknown date to 1970')
    end
  end

  context 'with an unknown interval end' do
    it 'returns a humanized interval string' do
      expect(Date.edtf('1970/unknown').humanize).to eq('1970 to unknown date')
    end
  end

  context 'with an approximate interval'
  it 'returns a humanized approximate interval string' do
    expect(Date.edtf('1970~/1980~').humanize).to(
      eq('circa 1970 to circa 1980')
    )
  end

  context 'with an iso date' do
    it 'returns a humanized ISO date string' do
      expect(Date.edtf('1975-07-01').humanize).to eq('July 1, 1975')
    end
  end

  context 'with an uncertain iso date' do
    it 'returns a humanized uncertain ISO date string' do
      expect(Date.edtf('1975?').humanize).to eq('1975?')
    end
  end

  context 'with an unspecified year iso date' do
    it 'returns a humanized unspecified year ISO date string' do
      expect(Date.edtf('197X').humanize).to eq('1970s (year unknown)')
    end

    it 'returns a humanized unspecified year in a century string' do
      expect(Date.edtf('19XX').humanize).to eq('20th century (year unknown)')
    end

    it 'returns a humanized unspecified year string for legacy u syntax' do
      expect(Date.edtf('197u').humanize).to eq('1970s (year unknown)')
    end

    it 'returns a humanized unspecified year string for year 0' do
      expect(Date.edtf('00XX').humanize).to eq('1st century (year unknown)')
    end

    it 'returns a humanized unspecified year string for years 100-999' do
      expect(Date.edtf('01XX').humanize).to eq('2nd century (year unknown)')
    end

    it 'returns a humanized unspecified year string for negative years' do
      expect(Date.edtf('-01XX').humanize).to eq('2nd century BCE (year unknown)')
    end

    it 'returns a humanized unspecified year string for negative decades' do
      expect(Date.edtf('-001X').humanize).to eq('10s BCE (year unknown)')
    end

    it 'returns a humanized unspecified year string with month precision' do
      expect(Date.edtf('00XX-05').humanize).to eq('May 00XX')
    end

    it 'returns a humanized unspecified year string in a set' do
      expect(Date.edtf('[198X,1990]').humanize).to eq('1980s (year unknown) or 1990')
    end
  end

  context 'with a season' do
    it 'returns a humanized season string' do
      expect(Date.edtf('1975-22').humanize).to eq('summer 1975')
    end

    it 'returns a humanized approximate season string' do
      expect(Date.edtf('1975-22~').humanize).to eq('circa summer 1975')
    end

    it 'returns a humanized uncertain and approximate season string' do
      expect(Date.edtf('1975-22?~').humanize).to eq('circa summer 1975?')
    end
  end

  context 'with a set' do
    it 'returns a humanized exclusive set string' do
      expect(Date.edtf('[1980, 1981, 1983]').humanize).to(
        eq('1980, 1981 or 1983')
      )
    end

    it 'returns a humanized inclusive set string' do
      expect(Date.edtf('{1980, 1981, 1983}').humanize).to(
        eq('1980, 1981 and 1983')
      )
    end

    it 'returns a humanized open (before) exclusive set string' do
      expect(Date.edtf('[..1980]').humanize).to eq('on or before 1980')
    end

    it 'returns a humanized open (after) exclusive set string' do
      expect(Date.edtf('[1980..]').humanize).to eq('on or after 1980')
    end

    it 'returns a humanized open (before) inclusive set string' do
      expect(Date.edtf('{..1980}').humanize).to eq('on and before 1980')
    end

    it 'returns a humanized open (after) inclusive set string' do
      expect(Date.edtf('{1980..}').humanize).to eq('on and after 1980')
    end
  end

  context 'with an unknown value' do
    it 'returns a humanized unknown string' do
      expect(Date.edtf('XXXX').humanize).to eq('unknown')
    end
  end
end
