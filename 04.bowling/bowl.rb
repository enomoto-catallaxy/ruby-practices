# frozen_string_literal: true

input_array = gets.split(',')

input_array.length.times do |i|
  input_array[i] = 10 if input_array[i] == 'X'
  input_array[i] = input_array[i].to_i
end

frame = 0
max_frame = 10
count = 0
score = [0] * max_frame

input_array.length.times do |i|
  if frame + 1 != max_frame
    if input_array[i] == 10
      if count.zero?
        count = 1
        score[frame] = score[frame] + input_array[i] + input_array[i + 1] + input_array[i + 2]
      else
        score[frame] = score[frame] + input_array[i] + input_array[i + 1]
      end
    elsif input_array[i] + score[frame] == 10
      score[frame] = score[frame] + input_array[i] + input_array[i + 1]
    else
      score[frame] = score[frame] + input_array[i]
    end

    count += 1

    if count == 2
      count = 0
      frame += 1
    end

  else
    score[frame] = score[frame] + input_array[i]
  end
end
puts score.sum
