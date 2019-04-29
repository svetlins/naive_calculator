require 'spec_helper'

module NaiveCalculator
  describe Calculator do
    let(:calculator) { Calculator.new }

    it 'evaluates simple terms' do
      expect(
        calculator.evaluate('1')
      ).to eq(1)
    end

    it 'evaluates sums' do
      expect(
        calculator.evaluate('68 + 1')
      ).to eq(69)
    end

    it 'evaluates products' do
      expect(
        calculator.evaluate('21 * 2')
      ).to eq(42)
    end

    it 'evaluates sums of more than 2 values' do
      expect(
        calculator.evaluate('1 + 1 + 1')
      ).to eq(3)
    end

    it 'evaluates products of more than 2 values' do
      expect(
        calculator.evaluate('2 * 2 * 2')
      ).to eq(8)
    end

    it 'evaluates exponents' do
      expect(
        calculator.evaluate('2^10')
      ).to eq(1024)

      expect(
        calculator.evaluate('2^2^2')
      ).to eq(16)
    end

    it 'evaluates signs' do
      expect(
        calculator.evaluate('-1')
      ).to eq(-1)

      expect(
        calculator.evaluate('1 - -5')
      ).to eq(6)
    end

    describe 'precedence' do
      specify 'multiplication is before addition' do
        expect(
          calculator.evaluate('1 + 2 * 3')
        ).to eq(7)
      end

      specify 'exponentiation is before multiplication' do
        expect(
          calculator.evaluate('2*2^10')
        ).to eq(2048)
      end

      specify 'unary minus is before exponentiation' do
        expect(
          calculator.evaluate('-2^2')
        ).to eq(4)
      end

      specify 'parens override precedence' do
        expect(
          calculator.evaluate('-(2^2)')
        ).to eq(-4)
      end
    end

    it 'respects parens' do
      expect(
        calculator.evaluate('(1 + 2) * 3')
      ).to eq(9)
    end

    it 'supports variables' do
      calculator.evaluate('x = 5')

      expect(
        calculator.evaluate('x')
      ).to eq(5)
    end

    it 'supports operations with variables' do
      calculator.evaluate('x = 5')

      expect(
        calculator.evaluate('x + 6')
      ).to eq(11)
    end

    it 'supports function definitions' do
      calculator.evaluate('f(x, y) = x*y')

      expect(
        calculator.evaluate('f(12, 2)')
      ).to eq(24)
    end

    it 'supports function calls with expressions' do
      expect(
        calculator.evaluate('pow(1+1, 2*(2+3))')
      ).to eq(1024)

      expect(
        calculator.evaluate('cos(-pi/(1+1))')
      ).to be_within(0.001).of(0)
    end

    it 'signals invalid input' do
      expect do
        calculator.evaluate('1 + + 1')
      end.to raise_error('Invalid input')
    end

    it 'handles decimal numbers without losing precision' do
      expect(
        calculator.evaluate('0.1 + 0.000000000000000000000001')
      ).to eq(BigDecimal('0.100000000000000000000001'))
    end

    it 'can plot expressions' do
      plot = calculator.evaluate('plot x*x, x from -2 to 2')

      expect(plot).to be_present

      expect(plot.function.call(2)).to eq(4)
      expect(plot.min_x).to eq(-2)
      expect(plot.max_x).to eq(2)
    end
  end
end
