Treetop.load File.expand_path('arithmetic', __dir__)

module NaiveCalculator
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
