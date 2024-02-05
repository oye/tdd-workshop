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
    it "returns the sum of the numbers minus the tax for 200(2): 222" do
      expect(string_calculator.add('3,16,200,5')).to eq 222
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

  context "with numbers larger than 99" do
    it "they have to 'pay tax' for their hundreds: '101' -> 100, '375,4' -> 376, '1000' -> 990" do
      expect(string_calculator.add('101')).to eq 100
      expect(string_calculator.add('375,4')).to eq 376
      expect(string_calculator.add('1000')).to eq 990
    end
  end

  context "with first line starting with // containing custom separator character: '//;\\n1;3" do
    it "this sign character also be used to split the numbers: 4" do
      expect(string_calculator.add('//;\n1;3')).to eq 4
    end
  end

  context "with exclamation marks surrounding numbers: '1,!999!'" do
    it "they do not 'pay tax': 1000" do
      expect(string_calculator.add('1,!999!')).to eq 1000
    end
  end

  context "with custom separator text surrounded by [] in first line: '//[*x*]\\n1*x*2*x*3'" do
    it "should also be used as a separator: 6" do
      expect(string_calculator.add('//[*x*]\n1*x*2*x*3')).to eq 6
    end
  end

end
