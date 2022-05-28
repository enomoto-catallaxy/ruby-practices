# frozen_string_literal: true

require 'optparse'
require 'etc'

def main
  @command = LsCommand.new(3)
  @options = ARGV.getopts('a', 'r', 'l')
  given = include_option_a?
  given = include_option_r?(given)
  given = include_option_l?(given)
  @command.run(given)
end

def include_option_a?
  if @options['a']
    Dir.glob('*', File::FNM_DOTMATCH)
  else
    Dir.glob('*')
  end
end

def include_option_r?(given)
  if @options['r']
    given.reverse
  else
    given
  end
end

def include_option_l?(given)
  if @options['l']
    fetch_long_details(given)
  else
    given
  end
end

def fetch_long_details(given)
  puts "total #{given.length}"
  @command = LsCommand.new(1)
  path = Dir.pwd
  user = Etc.getpwuid(File.stat(path).uid).name.ljust(15)
  group = Etc.getgrgid(File.stat(path).gid).name.ljust(15)
  given.length.times do |i|
    given[i] = File.stat(given[i]).mode.to_s.ljust(10) << File::Stat.new(given[i]).nlink.to_s.ljust(5) << user << group << File.size(given[i]).to_s.ljust(10) << File.atime(given[i]).to_s.ljust(10) << given[i]
  end
  given
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
