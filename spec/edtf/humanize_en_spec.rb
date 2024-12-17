# frozen_string_literal: true

require 'edtf-humanize'

RSpec.describe Edtf::Humanize do
  before do
    I18n.locale = :en
  end

  it { is_expected.to be_a(Module) }

  context 'with a decade' do
    it 'returns a humanized decade string' do
      expect(Date.edtf('199x').humanize).to eq('1990s')
    end
  end

  context 'with a century' do
    it 'returns a humanized century string' do
      expect(Date.edtf('19xx').humanize).to eq('1900s')
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
      expect(Date.edtf('197u').humanize).to eq('197X')
    end
  end

  context 'with a season' do
    it 'returns a humanized season string' do
      expect(Date.edtf('1975-22').humanize).to eq('summer 1975')
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
      expect(Date.edtf('uuuu').humanize).to eq('unknown')
    end
  end
end
