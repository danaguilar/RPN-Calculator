require_relative 'calculator'

#Using the rspec cheatsheet to reference different syntax
#Using https://www.anchor.com.au/wp-content/uploads/rspec_cheatsheet_attributed.pdf


describe Calculator  do
	before(:each)do
		@calculator = Calculator.new
	end

	describe 'operands' do
		it 'accepts and returns a number' do
			@calculator.parse_input('3')
			expect(@calculator.latest_result).to eq(3)
		end

		context 'when multiple numbers are given' do
			it 'returns the last one' do
				@calculator.parse_input('3 4')
				expect(@calculator.latest_result).to eq(4)
			end
		end
	end

	describe 'operators' do
		# Test cases for checking operations. Can be extended by following the given syntax
		# ["num, num, operator",answer]
		before(:all) do
			@test_inline_addition = [
				["2 5 +",7]
			]
			@test_inline_subtraction = [
				["5 2 -",3]
			]
			@test_inline_multiplication = [
				["5 2 *",10]
			]
			@test_inline_division = [
				["10 2 /",5]
			]
		end

		context 'When the "+" character is encountered' do
			it "throws an error if there are not two operands available" do
				expect(@calculator.parse_input("2 +")).to be false
			end
			it " it adds two operands together correctly" do
				@calculator.parse_input("2 5 +")
				expect(@calculator.latest_result).to eq(7)
			end
		end

		context 'When the "-" character is encountered' do
			it " it subtracts two operands together correctly" do
				@calculator.parse_input("5 2 -")
				expect(@calculator.latest_result).to eq(3)
			end
		end

		context 'When the "*" character is encountered' do
			it " it subtracts two operands together correctly" do
				@calculator.parse_input("5 2 *")
				expect(@calculator.latest_result).to eq(10)
			end
		end

		context 'When the "/" character is encountered' do
			it " it subtracts two operands together correctly" do
				@calculator.parse_input("10 2 /")
				expect(@calculator.latest_result).to eq(5)
			end
		end

		it "saves the stack when an error occurs"
	end
end
