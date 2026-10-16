# frozen_string_literal: true

require 'edtf-humanize'

RSpec.describe Edtf::Humanize do
  before do
    I18n.locale = :it
  end

  it { is_expected.to be_a(Module) }

  context 'with a decade' do
    it 'returns a humanized decade string' do
      expect(Date.edtf('199x').humanize).to eq('anni 1990')
    end

    it 'returns a humanized BC decade string' do
      expect(EDTF::Decade.new(-10).humanize).to eq('anni 10 a. C.')
    end
  end

  context 'with a century' do
    it 'returns a humanized century string' do
      expect(Date.edtf('19xx').humanize).to eq('XX secolo')
    end
  end

  context 'with an interval' do
    it 'returns a humanized interval string' do
      expect(Date.edtf('1970/1980').humanize).to eq('1970 - 1980')
    end

    it 'returns a humanized interval string with unspecified decades' do
      expect(Date.edtf('198X/199X').humanize).to eq('anni 1980 (anno sconosciuto) - anni 1990 (anno sconosciuto)')
    end

    it 'returns a humanized interval string with unspecified centuries' do
      expect(Date.edtf('19XX/20XX').humanize).to eq('XX secolo (anno sconosciuto) - XXI secolo (anno sconosciuto)')
    end
  end

  context 'with an open interval' do
    it 'returns a humanized interval string' do
      expect(Date.edtf('1970/open').humanize).to eq('1970 - ')
    end
  end

  context 'with an unknown interval start' do
    it 'returns a humanized interval string' do
      expect(Date.edtf('unknown/1970').humanize).to eq('data sconosciuta a 1970')
    end
  end

  context 'with an unknown interval end' do
    it 'returns a humanized interval string' do
      expect(Date.edtf('1970/unknown').humanize).to eq('1970 a data sconosciuta')
    end
  end

  context 'with an approximate interval'
  it 'returns a humanized approximate interval string' do
    expect(Date.edtf('1970~/1980~').humanize).to(
      eq('circa 1970 - circa 1980')
    )
  end

  context 'with an iso date' do
    it 'returns a humanized ISO date string' do
      expect(Date.edtf('1975-07-01').humanize).to eq('1 luglio 1975')
    end
  end

  context 'with an uncertain iso date' do
    it 'returns a humanized uncertain ISO date string' do
      expect(Date.edtf('1975?').humanize).to eq('1975 ?')
    end
  end

  context 'with an unspecified year iso date' do
    it 'returns a humanized unspecified year ISO date string' do
      expect(Date.edtf('197X').humanize).to eq('anni 1970 (anno sconosciuto)')
    end

    it 'returns a humanized unspecified year in a century string' do
      expect(Date.edtf('19XX').humanize).to eq('XX secolo (anno sconosciuto)')
    end

    it 'returns a humanized unspecified year string with month precision' do
      expect(Date.edtf('198X-05').humanize).to eq('maggio anni 1980 (anno sconosciuto)')
    end
  end

  context 'with an unspecified month or day' do
    it 'returns a humanized string with an unspecified month' do
      expect(Date.edtf('1990-XX').humanize).to eq('1990 (mese sconosciuto)')
    end

    it 'returns a humanized string with an unspecified month and day' do
      expect(Date.edtf('1990-XX-XX').humanize).to eq('1990 (data esatta sconosciuta)')
    end
  end

  context 'with a season' do
    it 'returns a humanized season string' do
      expect(Date.edtf('1975-22').humanize).to eq('estate 1975')
    end

    it 'returns a humanized approximate season string' do
      expect(Date.edtf('1975-22~').humanize).to eq('circa estate 1975')
    end

    it 'returns a humanized uncertain and approximate season string' do
      expect(Date.edtf('1975-22?~').humanize).to eq('circa estate 1975 ?')
    end
  end

  context 'with a set' do
    it 'returns a humanized exclusive set string' do
      expect(Date.edtf('[1980, 1981, 1983]').humanize).to(
        eq('1980, 1981 o 1983')
      )
    end

    it 'returns a humanized inclusive set string' do
      expect(Date.edtf('{1980, 1981, 1983}').humanize).to(
        eq('1980, 1981 e 1983')
      )
    end

    it 'returns a humanized open (before) exclusive set string' do
      expect(Date.edtf('[..1980]').humanize).to(
        eq('prima di 1980')
      )
    end

    it 'returns a humanized open (after) exclusive set string' do
      expect(Date.edtf('[1980..]').humanize).to(
        eq('dopo 1980')
      )
    end

    it 'returns a humanized open (before) inclusive set string' do
      expect(Date.edtf('{..1980}').humanize).to(
        eq('prima di 1980')
      )
    end

    it 'returns a humanized open (after) inclusive set string' do
      expect(Date.edtf('{1980..}').humanize).to(
        eq('dopo 1980')
      )
    end
  end

  context 'with an unknown value' do
    it 'returns a humanized unknown string' do
      expect(Date.edtf('XXXX').humanize).to eq('data sconosciuta')
    end
  end
end
