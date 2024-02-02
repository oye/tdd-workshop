require 'string_calculator'

RSpec.describe StringCalculator, '#add(numbers)' do
  string_calculator = StringCalculator.new
  context 'with single number' do
    it 'return the same number as int' do
      expect(string_calculator.add('1')).to eq 1
    end
  end
  context 'with two comma separated numbers' do
    it 'return the sum of the numbers' do
      expect(string_calculator.add('1,4')).to eq 5
    end
  end
end
