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

  def my_map(arg = nil)
    if block_given?
      arr = []
      my_each { |e| arr << yield(e) }
      arr
    else
      to_enum(:my_map)
    end
  end

  def my_inject(total = nil)
    total ||= 0 #si total existe, usa su valor...si no existe...asignale 0
    if (total.is_a? Numeric) && block_given?
      # puts "Soy Numeric, ejecutar logic aqui"
      my_each { |e| total = yield(total, e) }
    elsif (total.is_a? Symbol) && !block_given?
      puts "I'm a symbol, ejecutar logica aqui"
      case total
      when :+
        sum = 0
        my_each { |e| sum += e }
        return sum
      when :-
        minus = 0
        my_each { |e| minus -= e }
        return minus
      when :/
        divide = 1
        my_each { |e| divide = divide/e }
        return divide
      when :*
        multip = 1
        my_each { |e| multip *= e }
        return multip
      else
        puts "Soy un simbolo but....I'm not any of these symbols...no sirvo"
      end
    else
      #puts "We like highlighting mistakes here, !block !symbol(servible), !numeric, symbol+block(que no sirve)"
      return to_enum(:my_inject)
    end
  #elsif block_given? #si me dieron el bloque SOLITO ejecuto aqui
    #my_each { |e| total = yield(total, e) }
  total
  #"Termine"
  end

end

# p (1..4).my_inject(:Home){ |n| n + n } # => ERROR symbol (inservible), block NO TOMA SYMBOL + BLOCK

# p (1..4).my_inject(:+) # => 10 symbol, !block
# p (5..10).reduce(1, :*) # => 151200

# p (1..4).my_inject(1){ |total, n| total + n } # => 11 arg, bloque
# p [10, 30, 20, 60].my_inject(5){ |total, n| total + n } # => 125 arg, bloque

# p (5..10).my_inject{ |sum, n| sum + n } # => 45 !arg, Bloque
# p (5..10).my_inject(1) return to enum
# p (5..10).inject(:*)
p [100, 2].other_inject(:/)

# multip = 1
# [1, 2, 3, 4, 5].my_each { |e| puts multip *= e }
# puts multip