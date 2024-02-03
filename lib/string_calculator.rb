class StringCalculator
  def add(numbers)
    numbers_array = numbers.split(/,|\\n/).collect{|n| n.to_i} 
    
    negative_numbers = numbers_array.select{|n| n < 0}
    raise ArgumentError, "Negative numbers are not allowed: #{negative_numbers.join(', ')}" if negative_numbers.any?
    
    numbers.split(/,|\\n/).collect{|n| n.to_i}.sum
  end
end
