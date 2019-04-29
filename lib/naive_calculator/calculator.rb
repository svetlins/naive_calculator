Treetop.load File.expand_path('../arithmetic', __FILE__)

module NaiveCalculator
  class Calculator
    def initialize
      @environment = Environment.new
      @parser = ArithmeticParser.new
    end

    def evaluate(input)
      parse_tree = @parser.parse(input)

      if parse_tree
        parse_tree.eval(@environment)
      else
        raise 'Invalid input'
      end
    end
  end
end
