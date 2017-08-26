require_relative 'calculator'

#Using the rspec cheatsheet to reference different syntax
#Using https://www.anchor.com.au/wp-content/uploads/rspec_cheatsheet_attributed.pdf


describe Calculator  do
	describe 'operands' do
		before(:each)do
			@calculator = Calculator.new
		end
		it 'accepts and returns a number' do
			expect(@calculator.parse_input('3')).to eq(3)
		end

		context 'when multiple numbers are given' do
			it 'returns the last one' do
				expect(@calculator.parse_input('3 4')).to eq(4)
			end
		end

	describe 'operators' do
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
		describe 'addition' do

		end

	end

	end
end
