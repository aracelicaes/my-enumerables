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

  def my_count(arg = nil)
    if arg.nil? && !block_given?
      length
    elsif block_given?
      count = 0
      my_each { |e| count += 1 if yield e }
      count
    else
      arg_count = my_select { |e| e == arg }
      arg_count.length
    end
  end

end

ary = [1, 2, 4, 2, 3]
# p ary.my_count #=> 4
# p ary.my_count(2) #=> 2
# p ary.my_count{ |x| x%2==0 } #=> 3
# p ary.my_count(2) == ary.count(2)