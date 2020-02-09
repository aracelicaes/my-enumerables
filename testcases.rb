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

# p %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
# p %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
# p %w[ant bear cat].my_all?(/t/) #=> false
# p [nil, true, 99].all?(Integer) == [nil, true, 99].my_all?(Integer) #=> true

# ([1, 2, 3, 4, 5]).my_each { |n| p  "Current number is: #{n}" }
# (1..5).each { |n| p  "Current number is: #{n}" }
# p (1..5).each { |n| "Current number is: #{n}" } ==  (1..5).my_each { |n|  "Current number is: #{n}" }

# ([1, 2, 3, 4, 5]).my_each_with_index { |n, i| p "Number is: #{n}, Index is: #{i}" }
# (1..5).each_with_index { |n, i| p  "Number is: #{n}, Index is: #{i}" }
# p (1..5).each_with_index { |n, i| "Number is: #{n}, Index is: #{i}" } ==  (1..5).my_each_with_index { |n, i|  "Number is: #{n}, Index is: #{i}" }

# p [1,2,3,4,5].my_select { |num|  num.even?  }
# p (1..10).my_select { |i|  i % 3 == 0 }
# p (1..5).select { |i| i % 3 == 0 } ==  (1..5).my_select { |i| i % 3 == 0 }
