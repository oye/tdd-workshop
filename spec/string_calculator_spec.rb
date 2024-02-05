require 'string_calculator'

RSpec.describe StringCalculator, '#add(numbers)' do
  let(:string_calculator) { StringCalculator.new }

  context "with basic sum calculations" do
    it 'returns the number itself for a single number' do
      expect(string_calculator.add('1')).to eq 1
    end

    it "returns the sum for two comma separated numbers" do
      expect(string_calculator.add('1,4')).to eq 5
    end

    it "returns the sum for multiple comma separated numbers" do
      expect(string_calculator.add('3,16,200,5')).to eq 222
    end

    it "returns the sum for numbers separated by both comma and newline" do
      expect(string_calculator.add('45,16\n33\n2')).to eq 96
    end

    it "returns 0 for an empty string" do
      expect(string_calculator.add('')).to eq 0
    end
  end

  context "with special number handling" do
    it "throws an exception for negative numbers" do
      expect{string_calculator.add('-1,2,-3')}.to raise_error(ArgumentError, /^(?=.*-1)(?=.*-3).*/)
    end

    it "ignores numbers larger than 1000" do
      expect(string_calculator.add('1,1001')).to eq 1
    end
  end

  context "with tax calculations" do
    it "applies tax to numbers larger than 99" do
      expect(string_calculator.add('101')).to eq 100
      expect(string_calculator.add('375,4')).to eq 376
      expect(string_calculator.add('1000')).to eq 990
    end

    it "exempts encapsulated numbers from tax" do
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
