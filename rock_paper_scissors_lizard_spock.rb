VALID_CHOICES = %w[rock paper scissors lizard Spock].freeze()

def win?(first, second)
  case first
  when 'rock'
    second == 'scissors' || second == 'lizard'
  when 'paper'
    second == 'rock' || second == 'Spock'
  when 'scissors'
    second == 'paper' || second == 'lizard'
  when 'lizard'
    second == 'Spock' || second == 'paper'
  when 'Spock'
    second == 'scissors' || second == 'rock'
  end
end

def win_verb(first, second)
  case first
  when 'paper'
    second == 'rock' ? 'covers' : 'disproves'
  when 'scissors'
    second == 'paper' ? 'cuts' : 'decapitates'
  when 'lizard'
    second == 'Spock' ? 'poisons' : 'eats'
  when 'Spock'
    second == 'scissors' ? 'smashes' : 'vaporizes'
  else
    'crushes'
  end
end

def display_results(player, computer, score)
  Kernel.puts("You chose: #{player}; Computer chose: #{computer}")
  if win?(player, computer)
    update_score(0, score)
    prompt("#{player} #{win_verb(player, computer)} #{computer}")
    prompt('You win!')
  elsif win?(computer, player)
    update_score(1, score)
    prompt("#{computer} #{win_verb(computer, player)} #{player}")
    prompt('Computer wins!')
  else
    prompt("It's a tie!")
  end
  display_score(score)
end

def display_score(score)
  if score[0] > score[1]
    prompt("You're winning! #{score[0]} to #{score[1]}")
  elsif score[1] > score[0]
    prompt("The computer is winning! #{score[1]} to #{score[0]}")
  else
    prompt("The score is tied! #{score[0]} to #{score[1]}")
  end
end

def update_score(winner, score)
  if winner.zero?
    score[0] += 1
  elsif winner == 1
    score[1] += 1
  end
end

def game_over?(score)
  score[0] >= 5 || score[1] >= 5
end

def prompt(message)
  puts "=> #{message}"
end

def player_choice
  player = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    player = Kernel.gets().chomp()
    if player.length == 1
      player = VALID_CHOICES[VALID_CHOICES.map(&:chr).index(player)]
      break if player
    elsif VALID_CHOICES.include?(player)
      break
    end
    prompt("That's not a valid choice.")
  end
  player
end

def computer_choice
  VALID_CHOICES.sample()
end

score = [0, 0]
loop do # main loop
  display_results(player_choice, computer_choice, score)

  if game_over?(score)
    if score[0] >= 5
      prompt('Game Over. You Won!')
    else
      prompt('Game Over. You Lost!')
    end
    break
  else
    prompt('Do you want to keep playing? ("n" to forfeit)')
    if Kernel.gets().chomp().downcase().start_with?('n')
      break prompt('Game Over. You Forfeited!')
    end
  end
end
