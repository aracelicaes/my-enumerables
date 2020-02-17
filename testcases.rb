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