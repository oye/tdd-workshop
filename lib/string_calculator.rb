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

    tax_exempt = []
    numbers_array = numbers.split(split_regexp).map do |number|
      if number.start_with?('!') && number.end_with?('!')
        tax_exempt << number[1..-1].to_i
        number[1..-1].to_i
      else
        number.to_i
      end
    end

    numbers_array.reject!{|n| n > 1000}

    negative_numbers = numbers_array.select{|n| n < 0}
    raise ArgumentError, "Negative numbers are not allowed: #{negative_numbers.join(', ')}" if negative_numbers.any?
    
    # numbers greater than 99 that are not exempt have to pay tax
    numbers_array.map! do |number|
      if tax_exempt.include?(number)
        number
      else
        number - number/100
      end
    end

    numbers_array.collect{|n| n.to_i}.sum
  end
end
