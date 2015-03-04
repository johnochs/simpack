require 'spec_helper'

describe Simpack do

  describe 'simpack gem' do

    it 'has a version number' do
      expect(Simpack::VERSION).not_to be nil
    end

  end

  describe 'LCG' do

    context 'when initialized' do

      it 'has default values if no options hash is passed' do
        lcg = Simpack::LCG.new
        expect(lcg.multiplier).to be_kind_of(Integer)
        expect(lcg.increment).to be_kind_of(Integer)
        expect(lcg.modulus).to be_kind_of(Integer)
        expect(lcg.seed).to be_kind_of(Integer)
      end

      it 'allows for an options hash specifying multiplier, increment, modulus and seed' do
        options = {multiplier: 5, increment: 3, modulus: 8}
        lcg = Simpack::LCG.new(options)
        expect(lcg.multiplier).to eq(5)
        expect(lcg.increment).to eq(3)
        expect(lcg.modulus).to eq(8)
      end

    end

    context 'when initialized with bad values' do

      it 'raises exception if bad value is used for multiplier' do
        expect { Simpack::LCG.new(multiplier: 0) }.to raise_error("Invalid Multiplier")
      end

      it 'raises exception if bad value is used for modulus' do
        expect { Simpack::LCG.new(modulus: 0) }.to raise_error("Invalid Modulus")
      end

    end

  end

end
