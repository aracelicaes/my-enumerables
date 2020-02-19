p (1..4).my_inject(2, :Home)
p (1..4).my_inject(2, :*) # => 48 total, symbol WORKS! :)
p (5..10).my_inject(1, :+) # => 46 WORKS! :

p (5..10).my_inject(:*) # => 151200 IT WORKS! :)
p [100, 2].my_inject(:/) # => 50 it works! :

p (1..4).my_inject(1){ |sum, n| sum + n } # => 11 arg, bloque it works!
p (5..10).my_inject(5){ |sum, n| sum + n } # => 50 arg, Bloque it works

p [10, 30, 20, 60].my_inject{ |total, n| total + n } # => 120 !arg, bloqu
# p (5..10).my_inject(1) # !bloque # **can't pass this as a test case, always has 2 have args

longest = %w{ cat bear cacti }.my_inject do |memo, word|
  # p "Memo:#{memo} Word:#{word}"
  memo.length > word.length ? memo : word
  # p "Memo2:#{memo} Word2:#{word}"
end
p longest

# multip = 1
# [1, 2, 3, 4, 5].my_each { |e| puts multip *= e }
# puts multip
# p (1..4).my_map(1) { |i| i*i }  #=> [1, 4, 9, 16]
# p (1..4).my_map { "cat"  }   #=> ["cat", "cat", "cat", "cat"]


# ary = [1, 2, 4, 2, 3]
# p ary.my_count #=> 5
# p ary.my_count(2) #=> 2
# p ary.my_count{ |x| x%2==0 } #=> 3
# p ary.my_count(2) == ary.count(2)

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

=begin
rescue => exception
  
end
def my_inject(init = nil)
    if init #si me dan un parametro vas a checar todo lo que sigue, si no...checa si es un bloque
      p  total = 0
      if (init.is_a? Numeric) && block_given?
      p  my_each { |e| total += e if yield(e) } #how do I get it to also add the arg? and to take any operation? (- + * /)
      elsif (init.is_a? Symbol) && !block_given?
        puts "I'm a symbol, ejecutar logica aqui"
        case init
        when :+
          my_each { |e| total += e yield(e) }
        when :-
          puts "Soy Resta"
        when :/
          puts "Soy Division"
        when :*
          puts "Soy Multiplicacion"
        else
          puts "Soy un simbolo but....I'm not any of these symbols...no sirvo"
        end
      else
        puts "We like highlighting mistakes here, !block !symbol(servible), !numeric, symbol+block(que no sirve)"
      end
    elsif block_given? #si me dieron el bloque SOLITO ejecuto aqui
      puts "Me dieron un bloque pero no parametros por eso estamos aqui :D Ejecutando ando"
    else
      puts "No cumpli ninguna de las conidiciones de Arriba tons...regresamos un enumerable"
    end
    #"Termine"
    total
  end


  def my_inject(memo = nil, sym = nil)
    total = memo #si total existe, usa su valor...si no existe...asignale 0
    if total && total.is_a? Numeric  && block_given?
      # puts "Soy Numeric, ejecutar logic aqui"
      my_each { |e| total = yield(total, e) }
    elsif (total.is_a? Symbol) && !block_given?
      my_each { |e| total = total.send(sym, e) }
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

  def my_inject(memo = nil, sym = nil)
    #total =  self.to_a[0]# accumulator
    #p total
    if memo && (memo.is_a? Numeric) && block_given?
      # Checks if memo.nil? if it does..is it a #? Is there a block?
      my_each { |e| memo = yield(memo, e) }
    elsif memo.nil? && block_given?
      # if memo = nil but there's a block
      my_each { |e| total = yield(total, e)}
    elsif memo && (memo.is_a? Symbol) && !block_given?
      # This is when there's just 1 arg & it's a symbol
      my_each do |e|
        total = 5
        total = e.send(memo, total)
        p "Total #{total}, Memo #{memo}, e #{e}"
      end
      # my_each { |e| total = total.send(memo, e) }
    elsif (sym.is_a? Symbol) && !block_given?
      # This is when there's 2 args & one is a symbol, if one
      # is am symbol the other one will be a number automatically
      my_each { |e| total = e.send(sym, memo) }
    end
    total`
    # Returns total
  end

  def my_inject(total = nil, sym = nil)
    # total ||= 0 # si total existe, usa su valor...si no existe...asignale 0
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
      return operator_eval(total, sym) # si funciona
    # elsif !block_given? && (total.is_a? Numeric)
    #  return raise TypeError
    end
    total
  end
=end
