require 'spec_helper'

describe 'Simpack::Distribution' do

  describe 'Uniform' do

    it 'passes this test' do
      expect { Simpack::Distribution::Uniform.new(0, 10).cdf(5) }.not_to raise_error
    end

    context 'when initialized' do

      it 'takes arguments a & b describing the minimum and maximum values of its support' do
        expect { Simpack::Distribution::Uniform.new(0, 5) }.not_to raise_error
        expect { Simpack::Distribution::Uniform.new }.to raise_error
      end

      it 'raises an error if a > b' do
        expect { Simpack::Distribution::Uniform.new(3,2) }.to raise_error('Invalid support parameters')
      end

    end

    describe '#cdf' do

      subject(:ud) { Simpack::Distribution::Uniform.new(0,10) }

      it 'takes an integer or a float argument' do
        expect(ud.cdf(4)).to eq(ud.cdf(4.0))
      end

      it 'returns a float' do
        expect(ud.cdf(5)).to be_kind_of(Float)
      end

      it 'raises an error with an improper argument' do
        expect { ud.cdf('Whaaaaa???') }.to raise_error(ArgumentError)
      end

      it 'returns integer 1 for arguments >= its support' do
        expect(ud.cdf(10)).to eq(1)
        expect(ud.cdf(10)).to be_instance_of(Fixnum).or be_instance_of(Bignum)
        expect(ud.cdf(100)).to eq(1)
        expect(ud.cdf(100)).to be_kind_of(Fixnum).or be_instance_of(Bignum)
      end

      it 'returns integer 0 for arguments <= its support' do
        expect(ud.cdf(0)).to eq(0)
        expect(ud.cdf(0)).to be_instance_of(Fixnum).or be_instance_of(Bignum)
        expect(ud.cdf(-100)).to eq(0)
        expect(ud.cdf(-100)).to be_instance_of(Fixnum).or be_instance_of(Bignum)
      end

    end

    describe '#pdf' do

      subject(:ud) { Simpack::Distribution::Uniform.new(300.1, 400) }

      it 'takes an integer or a float argument' do
        expect(ud.pdf(251)).to eq(ud.pdf(251.00))
      end

      it 'returns a float when argument is inside its support' do
        expect(ud.pdf(399)).to be_instance_of(Float)
      end

      it 'raises an error with an improper argument' do
        arguments = [Object.new, 'Three Hundred Twenty Six', :totallywontwork]
        arguments.each do |arg|
          expect { ud.pdf(arg) }.to raise_error
        end
      end

      it 'returns integer 0 for arguments > its support' do
        expect(ud.pdf(300)).to eq(0)
        expect(ud.pdf(300)).to be_instance_of(Fixnum)
      end

      it 'returns integer 0 for arguments < its support' do
        expect(ud.pdf(50000)).to eq(0)
        expect(ud.pdf(50000)).to be_instance_of(Fixnum)
      end

    end

    describe '#mean' do

      it 'returns the proper value for the mean' do
        100.times do
          range = rand() * 10000
          a, b = [rand() * range, rand() * range].sort
          expect(Simpack::Distribution::Uniform.new(a, b).mean).to be_within(0.00001).of(0.5 * (a + b))
        end
      end

    end

    describe '#median' do

      it 'returns the proper value for the median' do
        100.times do
          range = rand() * 10000
          a, b = [rand() * range, rand() * range].sort
          expect(Simpack::Distribution::Uniform.new(a, b).median).to be_within(0.00001).of(0.5 * (a + b))
        end
      end

    end

    describe '#variance' do

      it 'returns the proper value for the variance' do
        100.times do
          range = rand() * 10000
          a, b = [rand() * range, rand() * range].sort
          expect(Simpack::Distribution::Uniform.new(a, b).variance).to be_within(0.00001).of((1.0 / 12) * (b - a) ** 2)
        end
      end

    end

    describe '#skewness' do

      it 'returns 0' do
        100.times do
          range = rand() * 10000
          a, b = [rand() * range, rand() * range].sort
          expect(Simpack::Distribution::Uniform.new(a, b).skewness).to eq(0)
        end
      end

    end

    describe '#excess_kurtosis' do

      it 'returns -6/5 (-1.2)' do
        100.times do
          range = rand() * 10000
          a, b = [rand() * range, rand() * range].sort
          expect(Simpack::Distribution::Uniform.new(a, b).excess_kurtosis).to eq(-6.0 / 5)
        end
      end

    end

    describe '#entropy' do

      it 'returns the proper value for the entropy' do
        100.times do
          range = rand() * 10000
          a, b = [rand() * range, rand() * range].sort
          expect(Simpack::Distribution::Uniform.new(a, b).entropy).to be_within(0.00001).of(Math.log(b - a))
        end
      end

    end

    describe '#sample' do

      context 'with bad parameters' do

        subject(:ud) { Simpack::Distribution::Uniform.new(3,5) }

        it 'raises an error if given more than one argument' do
          expect { ud.sample(55, 32) }.to raise_error(ArgumentError)
        end

        it 'raises an error if given an argument with an incorrect type' do
          expect { ud.sample('hello dolly!') }.to raise_error(ArgumentError)
        end

        it 'raises an error if given an argument with a negative value' do
          expect { ud.sample(-4) }.to raise_error('Invalid sample number')
        end

      end

      context 'with good parameters' do

        subject(:ud) { Simpack::Distribution::Uniform.new(200, 300) }

        it 'returns a single value if no arguments are given' do
          expect(ud.sample).to be_instance_of(Float)
        end

        it 'returns an array if a numerical argument > 1 is given' do
          expect(ud.sample(17)).to be_instance_of(Array)
        end

        it 'returns the correct number of random numbers' do
          1000.times do
            rand_num = (rand() * 1000).floor
            sample = ud.sample(rand_num)
            unless rand_num == 1
              expect(sample.size).to eq(rand_num)
            else
              expect(sample).to be_instance_of(Float)
            end
          end
        end

      end
    end

  end

end
