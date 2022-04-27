# frozen_string_literal: true

require 'optparse'

def main
  given = Dir.glob('*')
  opt = OptionParser.new
  opt.on('-r') { given = Dir.glob('*').reverse }
  opt.parse(ARGV)
  object = LsCommand.new(3)
  object.divide_case(given)
end

class LsCommand
  def initialize(number)
    @number = number
    @array = []
  end

  def print_column(given)
    @layer.times do |vertical|
      @number.times do |horizontal|
        @array[horizontal] = given[vertical + (horizontal * @layer)]
        printf("%15s\t", @array[horizontal])
        horizontal += 1
      end
      puts("\n")
      vertical + 1
      @array = []
    end
  end

  def divide_case(given)
    remainder = given.length / @number
    if remainder.zero?
      @layer = given.length / @number
    else
      @layer = (given.length / @number) + 1
      (@number - remainder).times do
        given.push('')
      end
    end
    print_column(given)
  end
end

main
