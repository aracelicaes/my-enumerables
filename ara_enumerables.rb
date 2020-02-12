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

  def my_map(arg = nil)
    if block_given?
      arr = []
      my_each { |e| arr.push(yield e) }
      arr
    else
      to_enum(:my_map)
    end
  end

  def my_inject(init = nil)
    if init #si me dan un parametro vas a checar todo lo que sigue, si no...checa si es un bloque
      if (init.is_a? Numeric) && block_given?
        puts "Soy Numeric, ejecutar logic aqui"
      elsif (init.is_a? Symbol) && !block_given?
        puts "I'm a symbol, ejecutar logica aqui"
        case init
        when :+
          puts "Soy suma"
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
    "Termine"
  end

end

# p (1..4).my_inject(:+){ |n| n + n }

p (1..4).my_map(1) { |i| i*i }  #=> [1, 4, 9, 16]
p (1..4).my_map { "cat"  }   #=> ["cat", "cat", "cat", "cat"]