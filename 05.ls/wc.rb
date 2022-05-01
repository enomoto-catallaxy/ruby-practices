# frozen_string_literal: true

require 'optparse'
require 'etc'

def main
  object = WcCommand.new
  object.output
end

class WcCommand
  def initialize
    @str = []
    @array = [3]
  end

  def output
    ARGV.length.times do |i| #入力されたファイルの数だけ単語数などを返す
      @str[i] = File.read(ARGV[i])
      @array[0] = count_lines(@str[i])
      @array[1] = count_words(@str[i])
      @array[2] = count_characters(@str[i])
      @array.length.times do |j|
        printf("%4s\t" % @array[j])
      end
      printf("%8s\t" % ARGV[i])
      puts('') #改行
      @str = [3] #初期化
    end
  end
  def count_lines(str)
    str.lines.count
  end
  def count_words(str)
    str.split(/\s+/).size
  end
  def count_characters(str)
    str.split(/\s+/).join.chars.size
  end

end

main
