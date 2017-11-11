VALID_CHOICES = %w[rock paper scissors].freeze()

def win?(first, second)
  (first == 'rock' && second == 'scissors') ||
    (first == 'paper' && second == 'rock') ||
    (first == 'scissors' && second == 'paper')
end

def display_results(player, computer)
  if win?(player, computer)
    prompt('You win!')
  elsif win?(computer, player)
    prompt('Computer wins!')
  else
    prompt("It's a tie!")
  end
end

def prompt(message)
  puts "=> #{message}"
end

loop do # main loop
  player = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    player = Kernel.gets().chomp().downcase()
    break if VALID_CHOICES.include?(player)
    prompt("That's not a valid choice.")
  end

  computer = VALID_CHOICES.sample()

  Kernel.puts("You chose: #{player}; Computer chose #{computer}")

  display_results(player, computer)

  prompt('Do you want to play again?')
  break unless Kernel.gets().chomp().downcase().start_with?('y')
end
