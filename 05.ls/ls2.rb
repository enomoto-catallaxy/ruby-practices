# frozen_string_literal: true

require 'optparse'

def main
  command = LsCommand.new(3)
  addhiddenfiles?
  given = includeoptiona?
  command.run(given)
end

def addhiddenfiles?
  @options = ARGV.getopts("a")
end

def includeoptiona?
  given =
    if @options["a"]
      Dir.glob('*', File::FNM_DOTMATCH)
    else
      Dir.glob('*')
    end
  return given
end

class LsCommand
  def initialize(number)
    @number = number
  end

  def print_column(given)
    @layer.times do |vertical|
      @number.times do |horizontal|
        printf("%15s\t", given[vertical + (horizontal * @layer)])
      end
      puts
    end
  end

  def divide_array(given)
    remainder = given.length % @number
    if remainder.zero?
      @layer = given.length / @number
    else
      @layer = (given.length / @number) + 1
      "#{given}#{' ' * (@number - remainder)}"
    end
    given
  end

  def run(given)
    devided_array = divide_array(given)
    print_column(devided_array)
  end
end

main
