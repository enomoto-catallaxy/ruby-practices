# frozen_string_literal: true

require 'optparse'
require 'etc'

def main
  @command = LsCommand.new(3)
  @options = ARGV.getopts('l')
  given = include_option_l?
  @command.run(given)
end

def files_with_long_details
  puts "total #{Dir.glob('*', File::FNM_DOTMATCH).length}"
  @command = LsCommand.new(1)
  given = []
  path = Dir.pwd
  user = Etc.getpwuid(File.stat(path).uid).name.ljust(12)
  group = Etc.getgrgid(File.stat(path).gid).name.ljust(12)
  Dir.glob('*').length.times do |i|
    given[i] = File.stat(Dir.glob('*')[i]).mode.to_s.ljust(11) << File::Stat.new(Dir.glob('*')[i]).nlink.to_s.ljust(2) << user << group << File.size(Dir.glob('*')[i]).to_s.ljust(5) << File.mtime(Dir.glob('*')[i]).strftime("%m月 %e %H:%M").ljust(13) << Dir.glob('*')[i].ljust(30)
  end
  given
end

def include_option_l?
  if @options['l']
    files_with_long_details
  else
    Dir.glob('*')
  end
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
