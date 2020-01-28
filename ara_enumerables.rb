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

  def my_all?(cond = nil)
     final = true
    if block_given?
      my_each { |b| final = false unless yield(b) }
    else
      my_each { |b| final = false unless b }
    end
     final
  end

end

=begin
([1, 2, 3, 4, 5]).my_each { |n| p  "Current number is: #{n}" }
(1..5).each { |n| p  "Current number is: #{n}" }
p (1..5).each { |n| "Current number is: #{n}" } ==  (1..5).my_each { |n|  "Current number is: #{n}" }
=end

=begin
([1, 2, 3, 4, 5]).my_each_with_index { |n, i| p "Number is: #{n}, Index is: #{i}" }
(1..5).each_with_index { |n, i| p  "Number is: #{n}, Index is: #{i}" }
p (1..5).each_with_index { |n, i| "Number is: #{n}, Index is: #{i}" } ==  (1..5).my_each_with_index { |n, i|  "Number is: #{n}, Index is: #{i}" }
=end

=begin
p [1,2,3,4,5].my_select { |num|  num.even?  }
p (1..10).my_select { |i|  i % 3 == 0 }
p (1..5).select { |i| i % 3 == 0 } ==  (1..5).my_select { |i| i % 3 == 0 }
=end

p [-2,4,5,6,7,8,9].my_all? { |n| n > 1}


p [3,4,5,6,7,8,9].my_all? { |n| n.even? }
p %w(aa bb cc).all? { |n| n.size == 3 }
p [3,4,5,6,7,8,9].all? { |n| n.even? } == [3,4,5,6,7,8,9].my_all? { |n| n.even? }
