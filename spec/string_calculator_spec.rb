require 'string_calculator'

RSpec.describe StringCalculator, '#add(numbers)' do
  string_calculator = StringCalculator.new
  
  context "with single number as parameter: '1'" do
    it 'return the same number as int: 1' do
      expect(string_calculator.add('1')).to eq 1
    end
  end
  
  context "with two comma separated numbers as parameter: '1,4'" do
    it "return the sum of the numbers as int: 5" do
      expect(string_calculator.add('1,4')).to eq 5
    end
  end
  
  context "with empty string as parameter: '' " do
    it 'return 0' do
      expect(string_calculator.add('')).to eq 0
    end
  end
  
  context "with any number of numbers as parameter: '3,16,200,5'" do
    it "returns the sum of the numbers: 224" do
      expect(string_calculator.add('3,16,200,5')).to eq 224
    end
  end
  
  context "with both newline and comma as separator: '45,16\\n33\\n2'" do
    it "return the sum of the numbers: 96" do
      expect(string_calculator.add('45,16\n33\n2')).to eq 96
    end
  end
  
  context "with negative numbers as parameter: '-1,2,-3'" do
    it "throws an exception containing the negative numbers: '-1,-3'" do
      expect{string_calculator.add('-1,2,-3')}.to raise_error(ArgumentError, /^(?=.*-1)(?=.*-3).*/)
    end
  end

  context "with numbers larger than 1000: '1,1001'" do
    it "inores them and returns the sum of the others: 1" do
      expect(string_calculator.add('1,1001')).to eq 1
    end
  end

end
