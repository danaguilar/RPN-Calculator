require_relative 'calculator'

#Using the rspec cheatsheet to reference different syntax
#Using https://www.anchor.com.au/wp-content/uploads/rspec_cheatsheet_attributed.pdf


describe Calculator  do 
	before do
		@calculator = Calculator.new
	end
	describe 'operands' do
		before do
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
		it 'accepts and returns a number' do
			expect(@calculator.calculate(3)).to eq(3)
		end

		it 'accepts multiple numbers and returns the last one'
	describe 'operators' do
		describe 'addition' do
			
		end

	end
		
	end
end