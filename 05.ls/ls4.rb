# frozen_string_literal: true

require 'optparse'
require 'etc'

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

def option_l(given)
  opt = OptionParser.new
  opt.on('-l') do
    puts "total #{given.length}"
    @object = LsCommand.new(1)
    times = []
    sizes = []
    ftypes = []
    nlinks = []
    permissions = []
    path = Dir.pwd
    user = Etc.getpwuid(File.stat(path).uid).name
    group = Etc.getgrgid(File.stat(path).gid).name
    given.length.times do |i|
      times[i] = File.atime(given[i]).to_s
      sizes[i] = File.size(given[i]).to_s
      ftypes[i] = File.ftype(given[i]).to_s
      nlinks[i] = File::Stat.new(given[i]).nlink.to_s
      permissions[i] = File.stat(given[i]).mode.to_s
      given[i] = ftypes[i]+ " " +permissions[i]  + " " + nlinks[i] + " " +  user + " " +group+" " +sizes[i]+ " " + times[i]+ " " +  given[i] 
    end
  end
  opt.parse(ARGV)
  given
end

def main
  given = Dir.glob('*')
  @object = LsCommand.new(3)
  option_l(given)
  @object.run(given)
end

main
