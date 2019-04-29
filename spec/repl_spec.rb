require 'spec_helper'

module NaiveCalculator
  describe Repl do
    describe 'can pretty print output' do
      specify do
        expect(
          Repl.pretty(BigDecimal.new('1.0'))
        ).to eq('=> 1')
      end

      specify do
        expect(
          Repl.pretty(BigDecimal.new('1.000001'))
        ).to eq('=> 1.000001')
      end

      specify do
        expect(
          Repl.pretty(BigDecimal.new('-1'))
        ).to eq('=> -1')
      end

      it 'prints strings without modification' do
        expect(
          Repl.pretty('- - -')
        ).to eq('- - -')
      end
    end

    it 'can plot' do
      expect(
        Repl.pretty(Plot.new(lambda { |x| x }, -1, 1))
      ).to be_present
    end
  end
end
