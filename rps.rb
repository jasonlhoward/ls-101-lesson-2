# In this assignment, we'll build a Rock Paper Scissors game.
# The game flow should go like this:

# the user makes a choice
# the computer makes a choice
# the winner is displayed

OPTIONS = %w[r p s].freeze()
OPTIONS_LONG = %w[Rock Paper Scissors].freeze
OPTIONS_WIN_VERB = %w[crushes covers cuts].freeze
RULES = [['s', 'p'], ['p', 'r'], ['r', 's']].freeze

def player_choice
  print "\nDo you choose (r)ock, (p)aper or (s)cissors? "
  loop do
    choice = Kernel.gets().chomp().downcase().chr
    return choice if OPTIONS.index(choice)
    print 'Invalid option! Please enter r, p or s: '
  end
end

def computer_choice
  computer_choices = []
  100.times { computer_choices += OPTIONS }
  computer_choices.sample()
end

def find_winner(choices)
  if choices.uniq.length == 1
    -1
  else
    RULES.each do |rule|
      break choices.index(rule[0]) if rule.sort == choices.sort
    end
  end
end

def winner_msg(winner, choices)
  return "\nIt's a tie!\n\n" if winner == -1
  player_choice = OPTIONS_LONG[OPTIONS.index(choices[0])]
  computer_choice = OPTIONS_LONG[OPTIONS.index(choices[1])]
  verb = OPTIONS_WIN_VERB[OPTIONS.index(choices[winner])]

  if winner.zero?
    "\n#{player_choice} #{verb} #{computer_choice}\nYou won!\n\n"
  else
    "\n#{computer_choice} #{verb} #{player_choice}\nThe computer won :(\n\n"
  end
end

def play_again?
  puts 'Would you like to play again?'
  print 'Type "STOP" to end or press <enter> to play again! '
  return if Kernel.gets().chomp().downcase() == 'stop'
  play
end

def play
  choices = []
  choices[0] = player_choice
  choices[1] = computer_choice
  puts "\nYou played: #{OPTIONS_LONG[OPTIONS.index(choices[0])]}"
  puts "The computer played: #{OPTIONS_LONG[OPTIONS.index(choices[1])]}"
  winner = find_winner(choices)
  puts winner_msg(winner, choices)
  play_again?
end

puts 'Play: Rock - Papers - Scissors'
play
