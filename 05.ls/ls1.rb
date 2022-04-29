# frozen_string_literal: true

class LsCommand
  def initialize(number)
    @number = number
  end

  def print_column(given)
    @layer.times do |vertical|
      @number.times do |horizontal|
        printf("%15s\t", given[vertical + (horizontal * @layer)])
      end
      puts("")
    end
  end

  def divide_array(given)
    remainder = given.length % @number
    if remainder.zero?
      @layer = given.length / @number
    else
      @layer = (given.length / @number) + 1
      (@number - remainder).times do
        given.push('')
      end
    end
    given
  end

  def run(given)
    devided_array = divide_array(given)
    print_column(devided_array)
  end
end

given = Dir.glob('*')
object = LsCommand.new(3)
object.run(given)
