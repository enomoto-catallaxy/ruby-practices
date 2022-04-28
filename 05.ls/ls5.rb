# frozen_string_literal: true

require 'optparse'
require 'etc'

def main
  given = Dir.glob('*')
  @object = LsCommand.new(3)
  option = Options.new
  given = option.multiple_options(given)
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

class Options
  def multiple_options(given)
    OptionParser.new do |opt|
      opt.on('-a') { given = option_a(given) }
      opt.on('-r') { given = option_r(given) }
      opt.on('-l') { given = option_a(given) }
      opt.on('-ar', '-ra') { given = option_ar(given) }
      opt.on('-rl', '-lr') { given = option_rl(given) }
      opt.on('-la', '-al') { given = option_la(given) }
      opt.on('-arl', '-alr', '-ral', '-rla', '-lar', '-lra') { given = option_arl(given) }

      opt.parse(ARGV)
    end
    given
  end

  def option_a(given)
    given = Dir.glob('*', File::FNM_DOTMATCH)
    given
  end

  def option_r(given)
    given = Dir.glob('*').reverse
    given
  end

  def option_l(given)
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
    given
  end

  def option_ar(given)
    given = option_a(given)
    given = option_r(given)
    given
  end

  def option_rl(given)
    given = option_r(given)
    given = option_l(given)
    given
  end

  def option_la(given)
    given = option_a(given)
    given = option_l(given)
    given
  end

  def option_arl(given)
    given = option_a(given)
    given = option_r(given)
    given = option_l(given)
    given
  end
end

main
