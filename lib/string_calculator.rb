class StringCalculator
  def add(numbers)

    return 0 if numbers.empty?
    
    # Extract possible custom delimiter character and words from first line in 'numbers'
    custom_delimiters, numbers = extract_custom_delimiters(numbers)

    # Extract possible numbers that are enclosed in exclamation marks. They are exempt from paying big number tax !555!.
    tax_exempt, numbers_array = extract_numbers(numbers, custom_delimiters)

    # Numbers larger than 1000 are ignored
    numbers_array.reject!{|n| n > 1000}

    # Check for negative numbers and raise an exception if any
    validate_negative_numbers(numbers_array)

    apply_tax_and_sum(numbers_array, tax_exempt)
  end

  private

  def extract_custom_delimiters(numbers)
    if numbers.start_with?('//')
      split_array = numbers.split('\\n', 2)
      custom_delimiter = Regexp.escape(split_array.first[2])
      custom_delimeter_words = split_array.first.scan(/\[(.*?)\]/).flatten
      numbers = split_array.last
      [/,|\\n|#{custom_delimiter}#{custom_delimeter_words.collect{|w| "|#{Regexp.escape(w)}"}.join}/, numbers]
    else
      [/,|\\n/, numbers]
    end
  end

  def extract_numbers(numbers, delimiters)
    tax_exempt = []
    numbers_array = numbers.split(delimiters).collect do |number|
      if number.start_with?('!') && number.end_with?('!')
        tax_exempt << number[1..-2].to_i
        number[1..-2].to_i
      else
        number.to_i
      end
    end
    [tax_exempt, numbers_array]
  end

  def validate_negative_numbers(numbers_array)
    negative_numbers = numbers_array.select { |n| n < 0 }
    raise ArgumentError, "Negative numbers are not allowed: #{negative_numbers.join(', ')}" if negative_numbers.any?
  end

  def apply_tax_and_sum(numbers_array, tax_exempt)
    numbers_array.collect do |number|
      if tax_exempt.include?(number)
        number
      else
        number - number / 100
      end
    end.sum
  end
end
