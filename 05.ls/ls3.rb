# frozen_string_literal: true

require 'optparse'

def main
  given = Dir.glob('*')
  @object = LsCommand.new(3)
  given = option_r(given)
  @object.run(given)
end

def option_r(given)
  opt = OptionParser.new
  opt.on('-r') { given = Dir.glob('*').reverse }
  opt.parse(ARGV)
  given
end

class LsCommand
  def initialize(number)
    @number = number
  end

  def print_column(given)
    array = []
    @layer.times do |vertical|
      @number.times do |horizontal|
        array[horizontal] = given[vertical + (horizontal * @layer)]
        printf("%30s\t", array[horizontal])
      end
      puts("\n")
      array = []
    end
  end

  def divide_array(given)
    quotient = given.length / @number
    if quotient.zero?
      @layer = given.length / @number
    else
      @layer = (given.length / @number) + 1
      (@number - quotient).times do
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

main
