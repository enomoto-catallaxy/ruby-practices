# frozen_string_literal: true

class Shot
  def initialize
    @input_array = ARGV[0].split(',')
  end

  def shot
    @input_array = @input_array.map do |input|
      input == 'X' ? 10 : input.to_i
    end
  end
end
