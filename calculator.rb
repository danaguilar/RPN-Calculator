class Calculator
	# Creates a caculator instance with a stack to track operand

	class Operation
		attr_reader :character, :argument_size, :function
		def initialize(character, argument_size, function)
			@character = character
			@argument_size = argument_size
			@function = function
		end
	end
	def initialize
		@stack = []
		@operations = [
			Operation.new('+',2, lambda { |nums| return nums[0] + nums[1]})
		]

	end

	# Adds a number to the stack
	def add_to_stack(num)
		@stack << num
	end

	# Returns, but does not remove, the next number in the stack
	def last_number
		return @stack[-1]
	end

	# Once an operator has been found, attempts to calculate it using the latest numbers in the stack
	def calculate(operation)
		if @stack.length >= operation.argument_size
			answer =  operation.function.call(@stack.pop(operation.argument_size))
		end
		add_to_stack(answer.to_r)
	end

	# Parses a raw string input into an array of inputs and processes each one individually
	def parse_input(str)
		input_array = str.split(' ')
		input_array.each do |item|
			operation_index = @operations.find_index{ |operation| item == operation.character}
			unless operation_index.nil?
				calculate(@operations[operation_index])
			else
				add_to_stack(item.to_r)
			end
		end
		return last_number
	end
end
