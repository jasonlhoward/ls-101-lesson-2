VALID_CHOICES = %w[rock paper scissors lizard Spock].freeze()

WINS = {
  'rock' => %w[scissors lizard],
  'paper' => %w[rock Spock],
  'scissors' => %w[paper lizard],
  'lizard' => %w[Spock paper],
  'Spock' => %w[scissors rock]
}.freeze

WIN_VERBS = {
  'rock' => {
    'scissors' => 'crushes',
    'lizard' => 'crushes'
  },
  'paper' => {
    'rock' => 'covers',
    'Spock' => 'disproves'
  },
  'scissors' => {
    'paper' => 'cuts',
    'lizard' => 'decapitates'
  },
  'lizard' => {
    'Spock' => 'poisons',
    'paper' => 'eats'
  },
  'Spock' => {
    'scissors' => 'smashes',
    'rock' => 'vaporizes'
  }
}.freeze

def win?(first, second)
  WINS[first].include?(second)
end

def win_verb(winner, loser)
  WIN_VERBS[winner][loser]
end

def display_results(player, computer)
  prompt("You chose: #{player}; Computer chose: #{computer}")
  if win?(player, computer)
    prompt("#{player} #{win_verb(player, computer)} #{computer}")
    prompt('You win!')
  elsif win?(computer, player)
    prompt("#{computer} #{win_verb(computer, player)} #{player}")
    prompt('Computer wins!')
  else
    prompt("It's a tie!")
  end
end

def display_score(score)
  player_score = score[0]
  computer_score = score[1]
  if player_score > computer_score
    prompt("You're winning #{player_score} to #{computer_score}!")
  elsif score[1] > score[0]
    prompt("The computer is winning #{computer_score} to #{player_score}!")
  else
    prompt("The score is tied #{player_score} to #{computer_score}!")
  end
end

def update_score(player, computer, score)
  score[0] += 1 if win?(player, computer)
  score[1] += 1 if win?(computer, player)
end

def game_over?(score)
  score[0] >= 5 || score[1] >= 5
end

def prompt(message)
  puts "=> #{message}"
end

def player_choose
  player = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    player = valid_player(Kernel.gets().chomp())
    break if player
    prompt('Invalid choice. Can also use r, p, s, l or S.')
  end
  player
end

def valid_player(player)
  if player.length == 1 && VALID_CHOICES.map(&:chr).index(player)
    player = VALID_CHOICES[VALID_CHOICES.map(&:chr).index(player)]
    valid_player(player)
  elsif VALID_CHOICES.include?(player)
    player
  else
    false
  end
end

def computer_choose
  VALID_CHOICES.sample()
end

prompt('Rock Paper Scissors Lizard Spock!')
prompt('First to 5 wins ends the game!')
score = [0, 0]
loop do
  player = player_choose
  computer = computer_choose
  update_score(player, computer, score)
  display_results(player, computer)
  display_score(score)

  next unless game_over?(score)
  if score[0] >= 5
    prompt('Game Over. You Won!')
  else
    prompt('Game Over. You Lost!')
  end
  break
end
