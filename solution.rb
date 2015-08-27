require "Prime"

class SmallestMultiple

  def initialize(input)
    @limit = input
    @answer = input
  end

  def lcm
    primes = (1..@limit).map {|num| prime_factors(num)}
    sort_out_dups(primes).inject(:*)
  end

  def prime_factors(number)
    if Prime.prime?(number)
      [number]
    else
      num = number
      prime_factor_list = []
      while (!Prime.prime?(num) && num != 1)
        (1..(Math.sqrt(num) + 1)).to_a.reverse.each do |n|
          if num % n == 0
            prime_factor_list << prime_factors(n)
            num /= n
          end
        end
      end
      prime_factor_list << num
      prime_factor_list.delete(1)
      prime_factor_list.flatten
    end
  end

  def sort_out_dups(nested_array)
    nested_array.inject([]) do |final, arr|
      arr.each do |number|
        (i = final.find_index(number)) && final.delete_at(i)
      end
      final << arr
      final.flatten
    end
  end
end

puts "smallest common multiple up to what number?"
limit = gets.strip.to_i
puts "answer: #{SmallestMultiple.new(limit).lcm}"