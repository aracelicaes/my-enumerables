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
      my_each do |i|
        arr.push(i) if yield(i)
      end
    end
    arr
  end

  def my_all?(arg = nil)
    false_count = 0
    if block_given?
      my_each { |e| false_count += 1 unless yield e }
    else
      use_it = same_validator(arg)
      my_each { |e| false_count += 1 unless use_it.call(e) }
    end
    !false_count.positive?
  end

  def my_none?(arg = nil)
    true_count = 0
    if block_given?
      my_each { |e| true_count += 1 if yield e }
    else
      use_it = same_validator(arg)
      my_each { |e| true_count += 1 if use_it.call(e) }
    end
    true_count.zero?
  end

  def my_any?(arg = nil)
    true_count = 0
    if block_given?
      my_each { |e| true_count += 1 if yield e }
    else
      use_it = same_validator(arg)
      my_each { |e| true_count += 1 if use_it.call(e) }
    end
    true_count.positive?
  end

  def same_validator(arg)
    if arg.nil?
      proc { |e| e }
    elsif arg.is_a? Regexp
      proc { |e| e.to_s.match(arg) }
    elsif arg.is_a? Class
      proc { |e| e.class == arg }
    else
      proc { |e| e == arg }
    end
  end

end

# p %w[ant bear cat].my_none? { |word| word.length == 5 } #=> true
# p %w[ant bear cat].my_none? { |word| word.length >= 4 } #=> false
# p %w[ant bear cat].my_none?(/d/) #=> true
# p [1, 3.14, 42].my_none?(Float) #=> false
# p [].my_none? == [].none? #=> true
# p [nil].my_none? #=> true
# p [nil, false].my_none? #=> true
# p [nil, false, true].my_none? #=> false
# p [nil, false, true].my_none? == [nil, false, true].none? #=> true

# p %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
# p %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
# p %w[ant bear cat].my_any?(/d/) #=> false
# p [nil, true, 99].my_any?(Integer) #=> true
# p [nil, true, 99].my_any? #=> true
# p [].my_any? #=> false

p %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
p %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
p %w[ant bear cat].my_all?(/t/) #=> false
p [nil, true, 99].all?(Integer) == [nil, true, 99].my_all?(Integer) #=> true

# ([1, 2, 3, 4, 5]).my_each { |n| p  "Current number is: #{n}" }
# (1..5).each { |n| p  "Current number is: #{n}" }
# p (1..5).each { |n| "Current number is: #{n}" } ==  (1..5).my_each { |n|  "Current number is: #{n}" }

# ([1, 2, 3, 4, 5]).my_each_with_index { |n, i| p "Number is: #{n}, Index is: #{i}" }
# (1..5).each_with_index { |n, i| p  "Number is: #{n}, Index is: #{i}" }
# p (1..5).each_with_index { |n, i| "Number is: #{n}, Index is: #{i}" } ==  (1..5).my_each_with_index { |n, i|  "Number is: #{n}, Index is: #{i}" }

# p [1,2,3,4,5].my_select { |num|  num.even?  }
# p (1..10).my_select { |i|  i % 3 == 0 }
# p (1..5).select { |i| i % 3 == 0 } ==  (1..5).my_select { |i| i % 3 == 0 }
