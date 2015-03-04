# Simpack
[![Code Climate](https://codeclimate.com/github/johnochs/simpack/badges/gpa.svg)](https://codeclimate.com/github/johnochs/simpack)
[![Test Coverage](https://codeclimate.com/github/johnochs/simpack/badges/coverage.svg)](https://codeclimate.com/github/johnochs/simpack)

Simpack is your go-to gem for your simulation needs in Ruby.  At its heart, Simpack is a linear congruential generator (LCG) which can then be used to generate random samples from a number of statistical distributions.

Use it for simulation, modeling, or games!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simpack'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simpack

## Usage

### Simpack::LCG

#### \#initialize

```ruby
lcg = Simpack::LCG.new
```

Optionally, you may wish to configure your LCG to suit your preferences with an options hash:

```ruby
lcg = Simpack::LCG.new({modulus: 8, multiplier: 5})
```
Keys for the options hash include the following:
* `:modulus`
* `:multiplier`
* `:increment`
* `:seed`

If you do decide to specify your own constants, all bets are off.  Simpack (as of now) does not test for constraints of the Hull-Dobell Theorem, or any other tests of period or uniformity.  This allows you to create a crappy LCG if you desire, but it will not alert you if you do.

See the __Technical Specs__ section for details of the standard configuration.

#### \#uniform

\#uniform can be called with an optional argument specifying the number of random numbers to return.

```ruby
> lcg.uniform
> 0.27662859533103207

> lcg.uniform(3)
> [0.9518568231847053, 0.7968659172399516, 0.15733885122680413]
```

## Contributing

Want to add a new distribution?  Have ideas for a feature?  Spotted a bug?  Contribute!  I am especially looking for people who have a bit more statistical knowledge than I do to spot any potential problems with the code.

1. Fork it ( https://github.com/johnochs/simpack/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

##Technical Specs

### Simpack::LCG

Table of standard parameters:

|Parameter |Value              |
|----------|-------------------|
|Modulus   | 2<sup>64          |
|Multiplier|6364136223846793005|
|Increment |1442695040888963407|
|Seed      |`Time.now.to_i`    |
