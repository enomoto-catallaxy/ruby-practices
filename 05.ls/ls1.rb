def vertical_sort(given_array)

  i = 3

  @length = given_array.length
    
  if @length % i == 0
    a_n = @length / i
    array == [a_n][i]
    k = 0
    while k < a_n do
      count = 0
      while count < i do
        array[k][count] = given_array[k + 1 +a_n * count]
        count += 1
      end
      k += 1
    end
    
  elsif @length % i == 1
    given_array.push("").push("")

    a_n = @length / i + 1
    array = [a_n][i]
    k = 0
    while k < a_n do
      count = 0
      while count < i do
        array[k][count] = given_array[k + 1 + a_n *count ]
        count += 1
      end
      k += 1
    end

  else #@length % i == 2
    given_array.push("")

    a_n = @length / i + 1
    array = [a_n][i]
    k = 0
    while k < a_n do
      count = 0
      while count < i do
        array[k][count] = given_array[k + 1 + a_n *count]
        count += 1
      end
      k += 1
    end
  end

  p array
end



given_array = Dir.glob('*')
vertical_sort(given_array)
      





