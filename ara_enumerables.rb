# frozen_string_literal: true

# my enumerable
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?
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

  def my_all?(arg = nil)
    if block_given?
      false_count = 0
      my_each { |e| false_count += 1 unless yield e }
      !false_count.positive?
    elsif arg == nil
      my_all? { |e| e }
    else
      my_all? { |e| arg === e }
    end
  end

  def my_any?(arg = nil)
    if block_given?
      true_count = 0
      my_each { |e| true_count += 1 if yield e }
      true_count.positive?
    elsif arg == nil?
      my_any? { |e| e }
    else
      my_any? { |e| arg === e }
    end
  end

end

=begin
p %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
p %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
p %w[ant bear cat].my_any?(/d/) #=> false
p [nil, true, 99].my_any?(Integer) #=> true
p [nil, true, 99].my_any? #=> true
p [].my_any? #=> false
=end

#p %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
#p %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
#p %w[ant bear cat].my_all?(/t/) #=> false
#p [nil, true, 99].any?(Integer) == [nil, true, 99].my_any?(Integer) #=> true

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
