require "simpack/version"

module Simpack

  class LCG

    attr_reader :multiplier, :modulus, :increment, :seed

    def initialize(options = {})
      default_options = {multiplier: 2147483629,
                         modulus: (2**31 - 1),
                         increment: 2147483587}

      options = default_options.merge(options)
      check_options(options)

      @multiplier = options[:multiplier]
      @modulus = options[:modulus]
      @increment = options[:increment]
      @seed = options[:seed] || Time.new.to_i
    end

    private

    def check_options(options)
      raise "Invalid Modulus" if options[:modulus] == 0
      raise "Invalid Multiplier" if options[:multiplier] == 0
    end

  end

end
