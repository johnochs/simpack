module Simpack
  module Distribution
    class Exponential

      def initialize(theta)
        check_validity(theta)
        @theta = theta
      end

      def pdf(x)
        theta * survival(x)
      end

      def cdf(x)
        1 - survival(x)
      end

      def mean
        1 / theta
      end

      def mode
        0
      end

      def survival(x)
        1 / (Math::E ** (theta * x))
      end

      private
      attr_reader :theta

      def check_validity(theta)
        raise 'Invalid parameter.' unless theta > 0
      end

    end
  end
end