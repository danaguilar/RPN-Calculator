class Calculator
	class Operation
		attr_reader :name, :character, :argument_size, :function
		def initialize(name,character, argument_size, function)
			@name = name
			@character = character
			@argument_size = argument_size
			@function = function
		end
	end

	# List of all current allowed operations for this calculator. Can be updated by simply adding a new operation to the array

	OPERATIONS = [
		Operation.new('Addition','+',2, lambda { |nums| return nums[0] + nums[1]}),
		Operation.new('Subtraction','-',2, lambda { |nums| return nums[0] - nums[1]}),
		Operation.new('Multiplication', '*',2, lambda { |nums| return nums[0] * nums[1]}),
		Operation.new('Division','/',2, lambda { |nums|
			raise ZeroDivisionError, "ZERO DIVISION ERROR: Cannot divide #{nums[0]} by #{nums[1]}" if nums[1] == 0
			return nums[0] / nums[1]
			})
		# To use another operation, add the new operation to this array with the following syntax
		# Operation.new('OperationName','OperationChar',number_of_operands, lambda { ** operation logic **})
	]

	attr_reader :stack

	def initialize
		@stack = []
		@error = 'No Errors'
		@saved_stack = []
	end

	# The only public method for this object. Takes in a new expression from an outside source and either computes it or rejects it with an error message
	def new_expression(input)
		if compute_expression(input)
			return [true, latest_result]
		else
			return [false, error_message]
		end
	end

	private

		# Backs up the current stack and attempts to run the given expression. If an error is found, catches the error, records it, and reverts the stack back to its old state
		def compute_expression(str)
			save_state
			begin
				parse_expression_string(str)
			rescue ArgumentError, ZeroDivisionError => e
				record_error(e.message)
				revert_state
				return false
			end
			return true
		end

		# Splits the expression into individual commands and processes them in order
		def parse_expression_string(str)
			command_array = str.split(' ')
			command_array.each do |command|
				process_command(command)
			end
		end

		# Processes an individual command. If it's a number, it stores the number. If it's a valid operation, it attempts to run the operation. Otherwise it throws and error
		def process_command(command)
			if is_number?(command)
				add_number_to_stack(command)
			elsif is_operation(command)
				run_operation(command)
			else
				raise ArgumentError, "ARGUMENT ERROR: #{command} is neither a number nor a recognized operation"
			end
		end

		# Takes a valid operation character and attempts to run that operation. Throws an error if there are not enough operands for the given operation. Adds the result to the stack if it is successful
		def run_operation(command)
			operation = get_operation(command)
			number_of_operands = operation.argument_size
			if @stack.length >= number_of_operands
				operands = get_operands(number_of_operands)
				result = operation.function.call(operands)
			else
				raise ArgumentError, "ARGUMENT ERROR: #{operation.name} requires #{operation.argument_size} operands. Only #{@stack.length} given."
			end
			add_number_to_stack(result)
		end


		# Adds a number to the stack
		def add_number_to_stack(num)
			@stack << num.to_f
		end

		# Returns, but does not remove, the next number in the stack
		def latest_result
			return @stack[-1]
		end

		# Records and error message for future use
		def record_error(msg)
			@error = msg
		end

		# Returns the most recent recorded error message
		def error_message
			return @error
		end

		# Saves the current stack in a backup
		def save_state
			@saved_stack = @stack.dup
		end

		# Returns the stack to its last saved state
		def revert_state
			@stack = @saved_stack
		end

		# Returns and removes the given number of operands from the stack.
		def get_operands(number_of_operands)
			return @stack.pop(number_of_operands)
		end

		# Returns the Operation object stored in the OPERATIONS constant that is related to the given character
		def get_operation(char)
			operation_index = OPERATIONS.find_index{ |operation| char == operation.character}
			return OPERATIONS[operation_index]
		end

		# Regex expression meant to test if a given string is a number
		def is_number?(test_str)
			test_str =~ /\A[-]?[0-9]*\.?[0-9]+\Z/
		end

		# Returns true if the given character corresponds to a Operation object in the OPERATIONS constant
		def is_operation(char)
			return true if OPERATIONS.find_index{ |operation| char == operation.character}
			return false
		end
end


class CalculatorIO
	def initialize
		@calculator = Calculator.new
	end

	def run
		while true
			print "input expression > "
			expression = gets.chomp
			break if expression == 'q' || expression == '' #   is the ASCII end-of-transmission command character most commonly seen in the terminal with ctrl-D
			result = @calculator.new_expression(expression)
			result[0] ? puts("result: #{result[1].to_f.round(3)}") : puts("#{result[1]}")
		end
		puts "Quitting..."
		puts "Thanks for using the RPN calculator"
	end
end


calc = CalculatorIO.new
calc.run if ARGV.empty? # Only run if no arguments are given. Therefore this run will be skipped during rspec's test runs
