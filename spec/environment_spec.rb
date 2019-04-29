require 'spec_helper'

module NaiveCalculator
  describe Environment do
    let(:env) { Environment.new }

    it 'can hold a value for a variable' do
      env.define_variable(:foo, 42)
      expect(env.lookup_variable(:foo)).to eq(42)
    end

    it 'signals missing variable' do
      expect do
        env.lookup_variable(:bar)
      end.to raise_error('No variable `bar`')
    end

    it 'can hold a function definition' do
      env.define_function(:bar, 1, lambda {})
      expect(env.lookup_function(:bar, 1)).to be_present
    end

    it 'signals missing function' do
      expect do
        env.lookup_function(:bar, 1)
      end.to raise_error('No function `bar`')
    end

    it 'checks arity of held function' do
      env.define_function(:bar, 1, lambda {})
      expect do
        env.lookup_function(:bar, 2)
      end.to raise_error('Function `bar` takes 1 argument(s) (2 given)')
    end

    it 'can dup itself' do
      env.define_variable(:foo, 42)
      new_env = env.dup
      new_env.define_variable(:foo, 69)

      expect(env.lookup_variable(:foo)).to eq(42)
      expect(new_env.lookup_variable(:foo)).to eq(69)
    end

    it 'has some builtins' do
      expect(env.lookup_variable(:pi)).to be_present
      expect(env.lookup_variable(:e)).to be_present

      expect(env.lookup_function(:sin, 1)).to be_present
      expect(env.lookup_function(:cos, 1)).to be_present
      expect(env.lookup_function(:log, 2)).to be_present
      expect(env.lookup_function(:pow, 2)).to be_present
    end
  end
end
