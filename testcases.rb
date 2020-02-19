p (1..4).my_inject(2, :Home)
p (1..4).my_inject(2, :*) # => 48 total, symbol WORKS! :)
p (5..10).my_inject(1, :+) # => 46 WORKS! :

p (5..10).my_inject(:*) # => 151200 IT WORKS! :)
p [100, 2].my_inject(:/) # => 50 it works! :

p (1..4).my_inject(1) { |sum, n| sum + n } # => 11 arg, bloque it works!
p (5..10).my_inject(5) { |sum, n| sum + n } # => 50 arg, Bloque it works

p [10, 30, 20, 60].my_inject { |total, n| total + n } # => 120 !arg, bloqu
# p (5..10).my_inject(1) # !bloque # **can't pass this as a test case, always has 2 have args

longest = %w[cat bear cacti].my_inject do |memo, word|
  # p "Memo:#{memo} Word:#{word}"
  memo.length > word.length ? memo : word
  # p "Memo2:#{memo} Word2:#{word}"
end
p longest

multip = 1
[1, 2, 3, 4, 5].my_each { |e| puts multip *= e }
puts multip
p (1..4).my_map(1) { |i| i * i } #=> [1, 4, 9, 16]
p (1..4).my_map { 'cat' } #=> ["cat", "cat", "cat", "cat"]

ary = [1, 2, 4, 2, 3]
p ary.my_count #=> 5
p ary.my_count(2) #=> 2
p ary.my_count(&:even?) #=> 3
p ary.my_count(2) == ary.count(2)

p %w[ant bear cat].my_none? { |word| word.length == 5 } #=> true
p %w[ant bear cat].my_none? { |word| word.length >= 4 } #=> false
p %w[ant bear cat].my_none?(/d/) #=> true
p [1, 3.14, 42].my_none?(Float) #=> false
p [].my_none? == [].none? #=> true
p [nil].my_none? #=> true
p [nil, false].my_none? #=> true
p [nil, false, true].my_none? #=> false
p [nil, false, true].my_none? == [nil, false, true].none? #=> true

p %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
p %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
p %w[ant bear cat].my_any?(/d/) #=> false
p [nil, true, 99].my_any?(Integer) #=> true
p [nil, true, 99].my_any? #=> true
p [].my_any? #=> false

p %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
p %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
p %w[ant bear cat].my_all?(/t/) #=> false
p [nil, true, 99].all?(Integer) == [nil, true, 99].my_all?(Integer) #=> true

[1, 2, 3, 4, 5].my_each { |n| p "Current number is: #{n}" }
(1..5).each { |n| p "Current number is: #{n}" }
p (1..5).each { |n| "Current number is: #{n}" } == (1..5).my_each { |n| "Current number is: #{n}" }

[1, 2, 3, 4, 5].my_each_with_index { |n, i| p "Number is: #{n}, Index is: #{i}" }
(1..5).each_with_index { |n, i| p "Number is: #{n}, Index is: #{i}" }
p (1..5).each_with_index { |n, i| "Number is: #{n}, Index is: #{i}" } == (1..5).my_each_with_index { |n, i| "Number is: #{n}, Index is: #{i}" }

p [1, 2, 3, 4, 5].my_select(&:even?)
p (1..10).my_select { |i| i % 3 == 0 }
p (1..5).select { |i| i % 3 == 0 } == (1..5).my_select { |i| i % 3 == 0 }
