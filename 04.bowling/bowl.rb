# frozen_string_literal: true

input_array = ARGV[0].split(',')

input_array = input_array.map do |input|
  input == 'X' ? 10 : input.to_i
end

frame = 0
MAX_FRAME = 10
count = 0
score = Array.new(MAX_FRAME, 0)

input_array.length.times do |i|
  if frame + 1 != MAX_FRAME
    if input_array[i] == 10
      if count.zero?
        count = 1
        score[frame] += input_array[i] + input_array[i + 1] + input_array[i + 2]
      else
        score[frame] += input_array[i] + input_array[i + 1]
      end
    elsif input_array[i] + score[frame] == 10
      score[frame] += input_array[i] + input_array[i + 1]
    else
      score[frame] += input_array[i]
    end

    count += 1

    if count == 2
      count = 0
      frame += 1
    end

  else
    score[frame] += input_array[i]
  end
end
puts score.sum
