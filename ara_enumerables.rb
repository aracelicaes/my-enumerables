# frozen_string_literal: true

# my enumerable
module Enumerable

  def my_each
    return to_enum unless block_given?
    
    i = 0
    while i < size
      yield(to_a[i])
      i += 1
    end
    self
  end
  
  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    while i < size
      yield(to_a[i], i)
      i += 1
    end
    self
  end

  def my_select
    return to_enum unless block_given?
    if block_given?
      arr = []
      self.my_each do | i |
        if yield(i)
          arr.push(i)
        end
      end
    end
    arr
  end

end

#([1, 2, 3, 4, 5]).my_each { |n| p  "Current number is: #{n}" }
#(1..5).each { |n| p  "Current number is: #{n}" }
#p (1..5).each { |n| "Current number is: #{n}" } ==  (1..5).my_each { |n|  "Current number is: #{n}" }
  
#([1, 2, 3, 4, 5]).my_each_with_index { |n, i| puts "Number is: #{n}, Index is: #{i}" }
#(1..5).each_with_index { |n, i| puts  "Number is: #{n}, Index is: #{i}" }
#puts (1..5).each_with_index { |n, i| "Number is: #{n}, Index is: #{i}" } ==  (1..5).my_each_with_index { |n, i|  "Number is: #{n}, Index is: #{i}" }

print [1,2,3,4,5].my_select { |num|  num.even?  }