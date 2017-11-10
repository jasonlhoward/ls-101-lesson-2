# ask the user for two numbers
# ask the user for an operation oto perform
# perform the operation on the two numbers
# output the result

# answer = Kernel.gets()
# Kernel.puts(answer)

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(n)
  n.to_i() != 0
end

def operation_to_message(op)
  case op
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

NUM_NOT_VALID_MSG = "Hmm... that doesn't look like a valid number".freeze()

number1 = nil
number2 = nil
operator = nil
name = nil

prompt('Welcome to Calculator! Enter your name: ')
loop do
  name = Kernel.gets().chomp()
  name.empty? ? prompt('Make sure to enter your name!') : break
end

prompt("Hi #{name}")

# main loop
loop do
  loop do
    prompt("What's the first number? ")
    number1 = Kernel.gets().chomp()
    valid_number?(number1) ? break : prompt(NUM_NOT_VALID_MSG)
  end

  loop do
    prompt("What's the second number? ")
    number2 = Kernel.gets().chomp()
    valid_number?(number2) ? break : prompt(NUM_NOT_VALID_MSG)
  end

  # TODO: shorten/refactor this prompt
  operator_prompt = <<-MSG
  What operation would you like to perform?
=> 1) add
=> 2) subtract
=> 3) multiply
=> 4) divide
  MSG
  prompt(operator_prompt)

  # TODO: validate operator
  loop do
    operator = gets().chomp()
    %w(1 2 3 4).include?(operator) ? break : prompt('Must enter 1, 2, 3, or 4')
  end

  prompt("#{operation_to_message(operator)} the two numbers...")

  result = case operator
          when '1'
            number1.to_i() + number2.to_i()
          when '2'
            number1.to_i() - number2.to_i()
          when '3'
            number1.to_i() * number2.to_i()
          when '4'
            number1.to_f() / number2.to_f() 
          end

  prompt("The result is: #{result}")
  
  # TODO: tell the user what operation is being performed
  
  prompt("Do you want to perform another calculation? Y or N")
  another = Kernel.gets().chomp()
  break unless another.downcase.start_with?('y')
end

