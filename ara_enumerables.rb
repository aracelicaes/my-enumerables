# my enumerable
require './utils.rb'
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
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < size
      yield(to_a[i], i)
      i += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    if block_given?
      arr = []
      my_each do |i|
        arr << i if yield(i)
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
      # p "We're here cause the arg is NIL"
      proc { |e| e }
    elsif arg.is_a? Regexp
      # p "We're here cause it's a REGEXP"
      proc { |e| e.to_s.match(arg) }
    elsif arg.instance_of? Class
      # p "We're here cause it's a class"
      proc { |e| e.is_a? arg }
    else
      # p "We're here cause we're eval pattern"
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

  def my_map
    if block_given?
      arr = []
      my_each { |e| arr << yield(e) }
      arr
    else
      to_enum(:my_map)
    end
  end

  def my_inject(total = nil, sym = nil)
    if block_given? && total.nil?
      initial = to_a[0]
      my_each_with_index do |e, i|
        next if i.zero?

        initial = yield(initial, e)
        total = initial
      end
    elsif (total.is_a? Numeric) && block_given?
      my_each { |e| total = yield(total, e) }
    elsif (total.is_a? Symbol) && !block_given?
      return operator_eval(total)
    elsif (total.is_a? Numeric) && (sym.is_a? Symbol) && !block_given?
      return operator_eval(total, sym)
    end
    total
  end
end

def multiply_els(arr)
  arr.my_inject(1) { |multip, e| multip * e }
end
# require './testcases.rb'
