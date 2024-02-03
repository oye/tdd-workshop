class StringCalculator
  def add(numbers)
    numbers.split(/,|\\n/).collect{|n| n.to_i}.sum
  end
end
