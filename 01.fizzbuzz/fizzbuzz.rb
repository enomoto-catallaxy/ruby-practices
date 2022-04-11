require 'debug'
i=1
while i <= 20 do
    if  i%3==0
        puts "Fizz"
        binding.break
    elsif i%5==0
        puts "Buzz"
    else
        puts i
    end

    i+=1
end