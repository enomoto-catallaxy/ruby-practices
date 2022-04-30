# frozen_string_literal: true

require 'optparse'
require 'etc'

def main
  given = Dir.glob('*')
  @object = LsCommand.new(3)
  given = multiple_options(given)
  @object.run(given)
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

def file_details
  @times = []
  @sizes = []
  @nlinks = []
  @permissions = []
  path = Dir.pwd
  @user = Etc.getpwuid(File.stat(path).uid).name
  @group = Etc.getgrgid(File.stat(path).gid).name
end

def multiple_options(given)
  file_details
  opt = OptionParser.new
  options = ARGV.getopts("a", "r", "l")
  if options["a"]
    given = Dir.glob('*', File::FNM_DOTMATCH)
  end
  if options["r"]
    given = given.reverse
  end
  if options["l"]
    puts "total #{given.length}"
    @object = LsCommand.new(1)
    given.length.times do |i|
      @times[i] = "%30s\t" % File.atime(given[i]).to_s
      @sizes[i] = "%10s\t" % File.size(given[i]).to_s
      @nlinks[i] = "%5s\t" % File::Stat.new(given[i]).nlink.to_s
      @permissions[i] ="0%o" % File.stat(given[i]).mode
      given[i] = @permissions[i] + @nlinks[i] + @user + @group+ @sizes[i] + @times[i] + given[i] 
    end
  end
  given
end

main
