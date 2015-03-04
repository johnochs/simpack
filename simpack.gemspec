# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simpack/version'

Gem::Specification.new do |spec|
  spec.name          = "simpack"
  spec.version       = Simpack::VERSION
  spec.authors       = ["John Ochs"]
  spec.email         = ["johnochs@me.com"]

  spec.summary       = %q{Simpack is your go-to gem for your simulation needs in Ruby. At its heart, Simpack is a linear congruential generator (LCG) which can then be used to generate random samples from a number of statistical distributions.}
  spec.description   = %q{A solution for all your simulation needs!}
  spec.homepage      = "https://github.com/johnochs/simpack"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry", "~> 0.10"
end
