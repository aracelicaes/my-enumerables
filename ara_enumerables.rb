# frozen_string_literal: true

# my enumerable
module Enumerable
  def my_each
    if block_given?
      for i in self
        yield(i)
      end
      self
    else
      to_enum(:my_each)
    end
  end
end
([1, 2, 3, 4, 5]).my_each { |n| p  "Current number is: #{n}" }
(1..5).each { |n| p  "Current number is: #{n}" }
p (1..5).each { |n| "Current number is: #{n}" }==  (1..5).my_each { |n|  "Current number is: #{n}" }