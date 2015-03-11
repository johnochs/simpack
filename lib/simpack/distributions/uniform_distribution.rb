module Simpack
  module Distribution

    class Uniform

      attr_reader :a, :b

      def initialize(a, b)
        @a = Float(a)
        @b = Float(b)
        check_validity(a, b)
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
