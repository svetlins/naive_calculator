module NaiveCalculator
  module Repl
    extend self

    def run
      init

      calculator = Calculator.new

      while input = Readline.readline("> ", true) do
        begin
          result = calculator.evaluate(input)
          pretty_print(result)
        rescue RuntimeError => e
          puts e.message
        end
      end
    end

    def init
      at_exit do
        puts "\nBye!"
      end

      Signal.trap(:INT) do
      end
    end

    def pretty(s)
      case s
      when BigDecimal
        '=> ' + s.to_s('F').chomp('.0')
      when Numeric
        '=> ' + s.to_s
      when Plot
        plot(s)
      else
        s.to_s
      end
    end

    def pretty_print(s)
      puts pretty(s)
    end

    def plot(plot_data)
      x_range = 80
      y_range = 10

      result = (y_range + 1).times.map {  ' ' * (x_range + 1) }

      samples = x_range.times.map do |x|
        rx = (x.to_f / x_range) * (plot_data.max_x - plot_data.min_x) + plot_data.min_x
        ry = plot_data.function.call(rx)

        [x, rx, ry]
      end

      min_y, max_y = [
        samples.min_by { |x, rx, ry| ry }.last.to_f,
        samples.max_by { |x, rx, ry| ry }.last.to_f,
      ]

      range = max_y - min_y

      samples.each do |x, rx, ry|
        scaled_y = ((ry - min_y) / range * y_range).round
        result[y_range - scaled_y][x] = 'O'
      end

      scaled_y_zero = (-min_y / range * y_range).round
      if (0...y_range).include? scaled_y_zero
        (x_range + 1).times do |x|
          result[y_range - scaled_y_zero][x] = '.' unless result[y_range - scaled_y_zero][x] == 'O'
        end
      end

      scaled_x_zero = (-plot_data.min_x.to_f / (plot_data.max_x - plot_data.min_x) * x_range).round
      if (0...x_range).include? scaled_x_zero
        (y_range + 1).times do |y|
          result[y_range - y][scaled_x_zero] = '.' unless result[y_range - y][scaled_x_zero] == 'O'
        end
      end

      result.join("\n")
    end
  end
end
