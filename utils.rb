def add_it(initial)
  sum = initial
  my_each { |e| sum += e }
  sum
end

def subtract_it(initial)
  minus = initial
  my_each_with_index do |e, i|
    next if i.zero?

    minus -= e
  end
  minus
end

def divide_it(initial)
  divide = initial
  my_each_with_index do |e, i|
    next if i.zero?

    divide /= e
  end
  divide
end

def multiply_it(initial, total)
  multip = 1
  multip *= initial if total.is_a? Numeric
  my_each { |e| multip *= e }
  multip
end

def operator_eval(total = nil, sym = nil)
  if total.is_a? Symbol
    operator = total
    initial = to_a[0]
  else
    operator = sym
    initial = total
  end

  case operator
  when :+
    add_it(initial)
  when :-
    subtract_it(initial)
  when :/
    divide_it(initial)
  when :*
    multiply_it(initial, total)
  else
    "I'm a symbol, but not any of these symbols"
  end
end
