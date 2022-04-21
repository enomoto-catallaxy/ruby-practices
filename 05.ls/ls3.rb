# frozen_string_literal: true

require 'optparse'

def main
  given = Dir.glob('*')
  opt = OptionParser.new
  opt.on('-r') { given = Dir.glob('*').reverse }
  opt.parse(ARGV)
  object = Sort.new(3)
  object.sort(given)
end

class Sort
  def initialize(number)
    @number = number
    @array = [] * @number
  end

  def matlix(given)
    @k = 0
    while @k < @a_n
      @j = 0
      while @j < @number
        @array[@j] = given[@k + (@j * @a_n)]
        printf("%15s\t", @array[@j])
        @j += 1
      end
      printf("\n")
      @k += 1
      @array = [] * @number
    end
  end

  def sort(given)
    remainder = given.length / @number
    if remainder.zero?
      @a_n = given.length / @number
    else
      @a_n = (given.length / @number) + 1
      (@number - remainder).times do
        given.push(``)
      end
    end
    matlix(given)
  end
end

main
