require_relative 'calculator'

#Using the rspec cheatsheet to reference different syntax
#Using https://www.anchor.com.au/wp-content/uploads/rspec_cheatsheet_attributed.pdf


describe Calculator  do

	before(:each)do
		@calculator = Calculator.new
	end

	describe 'Input' do
		context 'When given a number...' do
			it 'accept a single number' do
				expect(@calculator.new_expression('3')[0]).to be true
			end
			it 'accept multiple numbers' do
				expect(@calculator.new_expression('3 4.23 5 78 168')[0]).to be true
			end
		end
		context 'When given a character...' do
			context 'for characters that are valid operations...' do
				context "and there are enough given operands" do
					it 'accept addition(+)' do
						expect(@calculator.new_expression('5 2 +')[0]).to be true
					end
					it 'accept subtraction(-)' do
						expect(@calculator.new_expression('5 2 -')[0]).to be true
					end
					it 'accept multiplication(*)' do
						expect(@calculator.new_expression('5 2 *')[0]).to be true
					end
					it 'accept division(/)' do
						expect(@calculator.new_expression('5 2 /')[0]).to be true
					end
					it 'reject division over 0' do
						expect(@calculator.new_expression('5 0 /')[0]).to be false
					end
				end
				context "and there are not enough given operands..."do
					it 'reject addition(+)' do
						expect(@calculator.new_expression('2 +')[0]).to be false
					end
					it 'reject subtraction(-)' do
						expect(@calculator.new_expression('-')[0]).to be false
					end
					it 'reject multiplication(*)' do
						expect(@calculator.new_expression('5 *')[0]).to be false
					end
					it 'reject division(/)' do
						expect(@calculator.new_expression('5 /')[0]).to be false
					end
				end
			end
		context 'for characters that are not valid operations...' do
				it 'reject non valid operations' do
					expect(@calculator.new_expression('2 5 4 %')[0]).to be false
				end
			end
		end
	end

	describe 'Output' do
		context 'When given a single line equation...' do
			context 'if there is one operation...' do
				it 'perform addition correctly' do
					expect(@calculator.new_expression('5 2 +')[1]).to eq(7)
				end
				it 'perform subtraction correctly' do
					expect(@calculator.new_expression('5 2 -')[1]).to eq(3)
				end
				it 'perform multiplication correctly' do
					expect(@calculator.new_expression('5 2 *')[1]).to eq(10)
				end
				it 'perform division correctly' do
					expect(@calculator.new_expression('10 2 /')[1]).to eq(5)
				end
			end
			context 'For multiple operations...' do
				it 'perform operations from left to right' do
					expect(@calculator.new_expression('15 7 1 1 + - / 3 * 2 1 1 + + -')[1]).to eq(5)
				end
			end
		end
		context 'When given a multi line equation...' do
			it 'save given numbers for future use' do
				@calculator.new_expression('3')
				@calculator.new_expression('4')
				@calculator.new_expression('5')
				expect(@calculator.stack).to eq([3.0, 4.0, 5.0])
			end
			it 'use saved numbers for operations' do
				@calculator.new_expression('3')
				@calculator.new_expression('4')
				@calculator.new_expression('5')
				expect(@calculator.new_expression('+')[1]).to eq(9)
				expect(@calculator.new_expression('*')[1]).to eq(27)
			end
			context 'If an error occurs during a new_expression...' do
				it 'return error message' do
					@calculator.new_expression('3')
					@calculator.new_expression('4')
					@calculator.new_expression('5')
					expect(@calculator.new_expression('ERROR')[1]).to match /ERROR/
				end
				it 'revert to the state before new_expression was given' do
					@calculator.new_expression('3')
					@calculator.new_expression('0 /')
					expect(@calculator.stack).to eq([3.0])
				end
			end
		end
	end
end
