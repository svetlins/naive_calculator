require 'bigdecimal'
require 'active_support'
require 'active_support/core_ext'
require 'readline'
require 'treetop'

require 'naive_calculator/version'
require 'naive_calculator/repl'
require 'naive_calculator/plot'
require 'naive_calculator/environment'
require 'naive_calculator/calculator'

module NaiveCalculator
  class Error < StandardError; end
end
