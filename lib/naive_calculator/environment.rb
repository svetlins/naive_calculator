module NaiveCalculator
  class Environment
    Function = Struct.new(:arity, :body) do
      def to_s
        "function/#{arity}"
      end
    end

    def initialize(initial_bindings: {})
      @bindings = initial_bindings.merge builtin_variables
      @functions = builtin_functions
    end

    def initialize_copy(*)
      @bindings = @bindings.dup
      @functions = @functions.dup
    end

    def lookup_variable(name)
      @bindings[name] || raise("No variable `#{name}`")
    end

    def define_variable(name, value)
      @bindings[name] = value
    end

    def define_function(name, arity, body)
      @functions[name] = Function.new(arity, body)
    end

    def lookup_function(name, arity)
      function = @functions[name]

      raise "No function `#{name}`" unless function
      raise "Function `#{name}` takes #{function.arity} argument(s) (#{arity} given)" unless function.arity == arity

      function.body
    end

    private

    def builtin_variables
      {
        pi: BigDecimal(Math::PI, 15),
        e:  BigDecimal(Math::E, 15)
      }
    end

    def builtin_functions
      {
        sin: Function.new(1, ->(x) { BigDecimal(Math.sin(x), 10) }),
        cos: Function.new(1, ->(x) { BigDecimal(Math.cos(x), 10) }),
        log: Function.new(2, ->(x, y) { BigDecimal(Math.log(x, y), 10) }),
        pow: Function.new(2, ->(x, y) { x**y })

      }
    end
  end
end
