class StringCalculator
  def add(numbers)
    # find additonal split character in first line of parameter
    split_regexp = /,|\\n/
    if numbers.start_with?('//')
      split_array = numbers.split('\\n')
      custom_split_character = split_array.first[-1]
      split_regexp = /,|\\n|#{custom_split_character}/
      numbers = split_array.last
    end

    numbers_array = numbers.split(split_regexp).collect{|n| n.to_i}.reject{|n| n > 1000}

    negative_numbers = numbers_array.select{|n| n < 0}
    raise ArgumentError, "Negative numbers are not allowed: #{negative_numbers.join(', ')}" if negative_numbers.any?
    
    # numbers greater than 99 have to pay tax
    numbers_array.map!{|n| n - n/100}

    numbers_array.collect{|n| n.to_i}.sum
  end
end
