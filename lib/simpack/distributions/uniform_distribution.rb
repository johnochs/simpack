module Simpack
  module Distribution

    class Uniform

      attr_reader :a, :b

      def initialize(a, b)
        check_validity(a, b)
        @a = a
        @b = b
      end

      private

      def check_validity(a, b)
        raise 'Invalid support parameters' if a >= b
      end
    end

  end
end
