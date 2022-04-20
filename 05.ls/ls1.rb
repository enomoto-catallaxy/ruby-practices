#!/usr/bin/env ruby
class Sort
    def initialize(number)
        @number = number
    end

    def matlix(given_array)
        array = []*@number
        k = 0
        while k < @a_n do
            j = 0
            while j < @number do
                array[j] = given_array[k + j * @a_n]
                printf("%15s\t", array[j])
                j += 1
            end
            printf("\n")
            k += 1
            array = []*@number
        end
    end

    def sort(given_array)
        length = given_array.length
        remainder = length / @number
        if remainder == 0
            @a_n = length / @number
        else
            @a_n = length / @number + 1
            shortage = @number - remainder
            shortage.times do
                given_array = given_array.push("")
            end
        end
        matlix(given_array)
    end
end

given_array = Dir.glob('*')
object = Sort.new(3)
object.sort(given_array)