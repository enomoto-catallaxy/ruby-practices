def fizzbuzz(number)
  number.times do |i|
    if  i % 3 == 0
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