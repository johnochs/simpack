module Simpack
  module Distribution

    class Uniform

      attr_reader :a, :b

      def initialize(a, b)
        check_validity(a, b)
        @a = Float(a)
        @b = Float(b)
        @lcg = Simpack::LCG.new
      end

      def cdf(x)
        x = Float(x)
        return 0 if (x <= @a)
        return 1 if (x >= @b)
        (x - @a) / (@b - @a)
      end

      def pdf(x)
        x = Float(x)
        return 0 unless x.between?(@a, @b)
        1 / (@b - @a)
      end

      def sample(n = 1)
        n = Integer(n)
        raise 'Invalid sample number' if n < 0

        if n == 1
          return (@a + (@b - @a)) * @lcg.uniform
        else
          result = @lcg.uniform(n).map { |i| @a + (@b - @a) * i }
        end
        
        result
      end

      def mean; 0.5 * (@a + @b); end

      def median; 0.5 * (@a + @b); end

      def variance
        (1.0 / 12) * (@b - @a) ** 2
      end

      def skewness; 0; end

      def excess_kurtosis; -(6.0 / 5); end

      def entropy; Math.log(@b - @a); end

      private

      def check_validity(a, b)
        raise 'Invalid support parameters' if a >= b
      end

    end
  end
end
