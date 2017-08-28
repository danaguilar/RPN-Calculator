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

	OPERATIONS = [
		Operation.new('Addition','+',2, lambda { |nums| return nums[0] + nums[1]}),
		Operation.new('Substraction','-',2, lambda { |nums| return nums[0] - nums[1]}),
		Operation.new('Multiplication', '*',2, lambda { |nums| return nums[0] * nums[1]}),
		Operation.new('Division','/',2, lambda { |nums|
			raise ZeroDivisionError, "Zero Division Error: Cannot divide #{nums[0]} by #{nums[1]}" if nums[1] == 0
			return nums[0] / nums[1]
			})
	]

	attr_reader :stack

	def initialize
		@stack = []
		@error = 'No Errors'
		@saved_stack = []
	end

	def new_command(input)
		if compute(input)
			return [true, latest_result]
		else
			return [false, error_message]
		end
	end

	private

		def compute(str)
			save_state
			begin
				parse_command_string(str)
			rescue ArgumentError, ZeroDivisionError => e
				record_error(e.message)
				revert_state
				return false
			end
			return true
		end

		def parse_command_string(str)
			command_array = str.split(' ')
			command_array.each do |command|
				process_command(command)
			end
		end

		def process_command(command)
			if is_number?(command)
				add_number_to_stack(command)
			elsif is_operation(command)
				run_operation(command)
			else
				raise ArgumentError, "ArgumentError: #{command} is neither a number nor a recognized operation"
			end
		end

		def run_operation(command)
			operation = get_operation(command)
			number_of_operands = operation.argument_size
			if @stack.length >= number_of_operands
				operands = get_operands(number_of_operands)
				result = operation.function.call(operands)
			else
				raise ArgumentError, "Argument Error: #{operation.name} requires #{operation.argument_size} operands. Only #{@stack.length} given."
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

		def record_error(msg)
			@error = msg
		end

		def error_message
			return @error
		end

		def save_state
			@saved_stack = @stack.dup
		end

		def revert_state
			@stack = @saved_stack
		end

		def get_operands(number_of_operands)
			return @stack.pop(number_of_operands)
		end

		def get_operation(char)
			operation_index = OPERATIONS.find_index{ |operation| char == operation.character}
			return OPERATIONS[operation_index]
		end

		def is_number?(test_str)
			test_str =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
		end

		def is_operation(char)
			return true if OPERATIONS.find_index{ |operation| char == operation.character}
			return false
		end
end
