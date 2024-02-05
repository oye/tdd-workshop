require 'string_calculator'

RSpec.describe StringCalculator, '#add(numbers)' do
  let(:string_calculator) { StringCalculator.new }
  
  context "with single number" do
    it 'return the number itself' do
      expect(string_calculator.add('1')).to eq 1
    end
  end
  
  context "with two comma separated numbers" do
    it "return the sum of the numbers" do
      expect(string_calculator.add('1,4')).to eq 5
    end
  end
  
  context "with empty string as parameter: '' " do
    it 'return 0' do
      expect(string_calculator.add('')).to eq 0
    end
  end
  
  context "with multiple comma separated numbers" do
    it "returns the sum of the numbers minus the tax for numbers lager than 99" do
      expect(string_calculator.add('3,16,200,5')).to eq 222
    end
  end
  
  context "with numbers separated by both comma and newline" do
    it "return the sum of the numbers" do
      expect(string_calculator.add('45,16\n33\n2')).to eq 96
    end
  end
  
  context "with negative numbers" do
    it "throws an exception containing the negative numbers:" do
      expect{string_calculator.add('-1,2,-3')}.to raise_error(ArgumentError, /^(?=.*-1)(?=.*-3).*/)
    end
  end

  context "with numbers larger than 1000" do
    it "inores them and returns the sum of the others: 1" do
      expect(string_calculator.add('1,1001')).to eq 1
    end
  end

  context "with numbers larger than 99" do
    it "they have to pay large number tax equal to their hundreds didgit" do
      expect(string_calculator.add('101')).to eq 100
      expect(string_calculator.add('375,4')).to eq 376
      expect(string_calculator.add('1000')).to eq 990
    end
  end

  context "with exclamation marks encapsulating numbers" do
    it "they are exempt from paying large number tax" do
      expect(string_calculator.add('1,!999!')).to eq 1000
    end
  end

  context 'with custom delimiters' do
    it 'handles custom character delimiter' do
      expect(string_calculator.add('//;\n1;3')).to eq 4
    end

    it 'handles custom word delimiter' do
      expect(string_calculator.add('//[*x*]\n1*x*2*x*3')).to eq 6
    end

    it 'handles multiple custom delimiters' do
      expect(string_calculator.add('//[xyz][$][**]\n1$5xyz**2')).to eq 8
    end
  end

end
