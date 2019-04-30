Treetop.load File.expand_path('arithmetic', __dir__)

module NaiveCalculator
  # Runs a subprocess and applies handlers for stdout and stderr
  # Params:
  # +command+:: command line string to be executed by the system
  # +outhandler+:: +Proc+ object that takes a pipe object as first and only param (may be nil)
  # +errhandler+:: +Proc+ object that takes a pipe object as first and only param (may be nil)
  class Calculator
    def initialize
      @environment = Environment.new
      @parser = ArithmeticParser.new
    end

    def evaluate(input)
      parse_tree = @parser.parse(input)
      raise 'Invalid input' unless parse_tree

      parse_tree.eval(@environment)
    end
  end
end
