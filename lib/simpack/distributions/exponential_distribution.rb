module Simpack
  module Distribution
    class Exponential

      def initialize(lambda)
        check_validity(lambda)
        @lambda = lambda.to_f
      end

      def pdf(x); lambda * survival(x); end

      def cdf(x); 1 - survival(x); end

      def mean; 1.0 / lambda; end

      def mode; 0; end

      def survival(x); 1 / (Math::E ** (lambda * x)); end

      private
      attr_reader :lambda

      def check_validity(lambda)
        raise 'Invalid parameter' unless lambda > 0
      end

    end
  end
end
