# frozen_string_literal: true

require 'optparse'

def main
  given = Dir.glob('*').to_s
  opt = OptionParser.new
  opt.on('-l') do
    given = Dir.glob('*')
    @times = [] * (given.length)
    @sizes = [] * (given.length)
    @ftypes = [] * (given.length)
    given.length.times do |i|
      @times[i] = File.atime(given[i]).to_s
      @sizes[i] = File.size(given[i]).to_s
      @ftypes[i] = File.ftype(given[i]).to_s
      given[i] = given[i] + " " + @times[i] + " " + @sizes[i] + " " +  @ftypes[i]
    end
  end
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
        printf("%40s\t", @array[@j])
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
