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

    describe '#sample' do

      subject(:lcg) { Simpack::LCG.new }

      it 'can be called with out an argument to return a single number' do
        expect(lcg.uniform).to be_kind_of(Float)
      end

      it 'can be called with an integer argument to return an array of numbers' do
        result = lcg.uniform(5)
        expect(result).to be_kind_of(Array)
        expect(result).to all( be_a(Float) )
      end

      it 'when called with an integer argument, returns that number of items' do
        rand_num = (100 * rand()).floor
        expect(lcg.uniform(rand_num).size).to eq(rand_num)
      end

    end

    context 'correctness of output' do

      describe 'general conditions' do

        it 'only outputs numbers between 0 & 1' do
          results = Simpack::LCG.new.uniform(10000)
          expect(results).to all( be > 0.0 )
          expect(results).to all( be < 1.0 )
        end

      end

      describe 'tests' do

        it 'passes chi-squared test for alpha = 0.05' do
          test_statistics = []
          chi_squared_quantile = 16.92

          100.times do
            sample = Simpack::LCG.new.uniform(10000)

            fis = []
            k = 10

            # Calculates number of random numbers falling into subintervals
            # [(i-1)/k, i/k]
            (1..k).each do |i|
              fis << sample.select { |el| el.between?((i - 1)/k.to_f, i/k.to_f) }.size
            end

            sum = 0

            (1..k).each do |i|
              sum += (fis[i - 1].to_f - sample.size.to_f / k) ** 2
            end

            chi_squared_test_statistic = (k.to_f / sample.size) * sum
            test_statistics << chi_squared_test_statistic
          end

          expect(test_statistics.count { |i| i < chi_squared_quantile }).to be >= 95
        end
      end

    end

  end

end
