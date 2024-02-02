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
end
