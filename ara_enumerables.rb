# frozen_string_literal: true

module Enumerable
  def my_each
    finally = []

    i = 0
    while i < array.length
      finally << yield(array[i])
      i += 1
    end

    return finally
  end
end

my_each([1,2,3,4]) do |x| x*2 end
puts "#{x}"
