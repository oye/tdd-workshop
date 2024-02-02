class StringCalculator
  def add(numbers)
    numbers.split(',').collect{|n| n.to_i}.sum
  end
end
