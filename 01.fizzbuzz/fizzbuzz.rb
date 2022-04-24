def main
  object = Number.new(20)
  object.fizzbuzz
end

class Number
  def initialize(number)
    @number = number
  end

  def fizzbuzz
    numbers = (1..@number)
    numbers.each do |i|
      if  i % 15 == 0
        puts "FizzBuzz"
      elsif i %3 == 0
        puts "Fizz"
      elsif i % 5 == 0
        puts "Buzz"
      else
        puts i
      end
    end
  end
end

main
