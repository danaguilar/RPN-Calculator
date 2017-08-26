class Calculator
	# Creates a caculator instance with a stack to track operand
	def initialize
		@stack = []
	end

	# Adds a number to the stack
	def add_to_stack(num)
		@stack << num
	end

	# Returns, but does not remove, the next number in the stack
	def last_number
		return @stack[-1]
	end

	# Parses a raw string input into an array of inputs and processes each one individually
	def parse_input(str, show_stack = false)
		input_array = str.split(' ')
		input_array.each do |item|
			add_to_stack(item.to_r)
		end
		return last_number
	end
end
