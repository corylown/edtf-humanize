# frozen_string_literal: true

require 'edtf-humanize'

RSpec.describe Edtf::Humanize do
  before do
    I18n.locale = :fr
  end

  it { is_expected.to be_a(Module) }

  context 'with a decade' do
    it 'returns a humanized decade string' do
      expect(Date.edtf('199x').humanize).to eq('Les années 1990')
    end
  end

  context 'with a century' do
    it 'returns a humanized century string' do
      expect(Date.edtf('19xx').humanize).to eq('XXe siècle')
    end
  end

  context 'with an interval' do
    it 'returns a humanized interval string' do
      expect(Date.edtf('1970/1980').humanize).to eq('De 1970 à 1980')
    end
  end

  context 'with an open interval' do
    it 'returns a humanized interval string' do
      expect(Date.edtf('1970/open').humanize).to eq('Depuis 1970')
    end
  end

  context 'with an unknown interval start' do
    it 'returns a humanized interval string' do
      expect(Date.edtf('unknown/1970').humanize).to eq("date inconnue jusqu'en 1970")
    end
  end

  context 'with an unknown interval end' do
    it 'returns a humanized interval string' do
      expect(Date.edtf('1970/unknown').humanize).to eq('1970 à date inconnue')
    end
  end

  context 'with an approximate interval'
  it 'returns a humanized approximate interval string' do
    expect(Date.edtf('1970~/1980~').humanize).to(
      eq('De 1970 environ à 1980 environ')
    )
  end

  context 'with an iso date' do
    it 'returns a humanized ISO date string' do
      expect(Date.edtf('1975-07-01').humanize).to eq('1 Juillet 1975')
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
      expect(Date.edtf('1975-22').humanize).to eq('été 1975')
    end
  end

  context 'with a set' do
    it 'returns a humanized exclusive set string' do
      expect(Date.edtf('[1980, 1981, 1983]').humanize).to(
        eq('1980, 1981 ou 1983')
      )
    end

    it 'returns a humanized inclusive set string' do
      expect(Date.edtf('{1980, 1981, 1983}').humanize).to(
        eq('1980, 1981 et 1983')
      )
    end

    it 'returns a humanized open (before) exclusive set string' do
      expect(Date.edtf('[..1980]').humanize).to(
        eq('Le ou avant 1980')
      )
    end

    it 'returns a humanized open (after) exclusive set string' do
      expect(Date.edtf('[1980..]').humanize).to(
        eq('Le ou après 1980')
      )
    end

    it 'returns a humanized open (before) inclusive set string' do
      expect(Date.edtf('{..1980}').humanize).to(
        eq('Le et avant 1980')
      )
    end

    it 'returns a humanized open (after) inclusive set string' do
      expect(Date.edtf('{1980..}').humanize).to(
        eq('Le et après 1980')
      )
    end
  end

  context 'with an unknown value' do
    it 'returns a humanized unknown string' do
      expect(Date.edtf('uuuu').humanize).to eq('Inconnue')
    end
  end
end
