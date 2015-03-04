require "simpack/version"

module Simpack

  class LCG

    attr_reader :multiplier, :modulus, :increment, :seed

    def initialize(options = {})
      default_options = {multiplier: 6364136223846793005,
                         modulus: 2 ** 64,
                         increment: 1442695040888963407,
                         seed: Time.now.to_i}

      options = default_options.merge(options)
      check_options(options)

      @multiplier = options[:multiplier]
      @modulus = options[:modulus]
      @increment = options[:increment]
      @seed = @x = options[:seed]
    end

    def uniform(n = 1)
      return generate_number if n == 1

      results = Array.new(n)
      (0...n).each do |i|
        results[i] = generate_number
      end
      results
    end

    private

    def check_options(options)
      raise "Invalid Modulus" if options[:modulus] == 0
      raise "Invalid Multiplier" if options[:multiplier] == 0
    end

    def generate_number
      @x = (@multiplier * @x + @increment) % @modulus
      @x / @modulus.to_f
    end

  end

end
