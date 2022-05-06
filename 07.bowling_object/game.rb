# frozen_string_literal: true

require './shot'

MAX_FRAME = 10
MAX_MARK = 10

class Game
  def initialize
    @frame = 0
    @count = 0
    @score = Array.new(MAX_FRAME, 0)
  end

  def game_score(input_array)
    input_array.length.times do |i|
      if @frame + 1 != MAX_FRAME
        @score[@frame] = frame_one_to_nine(input_array[i], input_array[i + 1], input_array[i + 2], @frame, @score)
        @count += 1
        if @count == 2
          @count = 0
          @frame += 1
        end
      else
        @score[@frame] += input_array[i]
      end
    end
    puts @score.sum
  end

  def frame_one_to_nine(array_zero, array_one, array_two, frame, score)
    score[frame] +=
      if array_zero == MAX_MARK
        if @count.zero?
          @count = 1
          array_zero + array_one + array_two
        else
          array_zero + array_one
        end
      elsif array_zero + score[frame] == MAX_MARK
        array_zero + array_one
      else
        array_zero
      end
    score[frame]
  end
end

input_array = Shot.new.shot
game = Game.new
game.game_score(input_array)
