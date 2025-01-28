# game should print a depiction of the mastermind board game on each round
# round should continue until the player wins or runs out of attempts
# each round the amount of correctly placed pins should be displayed along with the amount of incorrect pins
# 12 total rounds
class Game
  attr_accessor(:arr, :turn, :feedback)

  def initialize(arr)
    @turn = 1
    @arr = arr
    @feedback = 0
  end

  def draw_board
    12.times { |i| puts "#{i} #{arr[i]}" }
  end

  def increment_turn
    self.turn += 1
  end
end

current_game = Game.new([%w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _],
                         %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _],
                         %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _]])

def playing(current_game)
  current_game.draw_board
  while current_game.turn <= 12
    puts "Current Turn: #{current_game.turn}"
    puts "input 'A B C D' in the correct order to break the code!"
    input = gets.chomp
    current_game.increment_turn
  end
  puts 'Game Over: Turn limit reached!'
end

playing(current_game)
