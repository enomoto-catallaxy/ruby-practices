def fizzbuzz(number)
  (number + 1).times do |i|
    if i.zero?
      puts ""
    elsif  i % 15 == 0
      puts "FizzBuzz"
    elsif i %3 == 0
      puts "Fizz"
    elsif i % 5 == 0
      puts "Buzz"
    else
      puts i
    end

    i+=1
  end
end

fizzbuzz(20)