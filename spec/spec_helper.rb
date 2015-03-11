$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require "codeclimate-test-reporter"
ENV['CODECLIMATE_REPO_TOKEN'] = '434d4cfa388ad2146c71bca82bf4cb9693336f208412c7378c2c099de8f81326'
CodeClimate::TestReporter.start

require 'simpack'
require 'byebug'
