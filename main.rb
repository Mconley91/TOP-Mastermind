# game should print a depiction of the mastermind board game on each round
# round should continue until the player wins or runs out of attempts
# each round the amount of correctly placed pins should be displayed along with the amount of incorrect pins
# 12 total rounds
class Game
  attr_accessor(:arr, :turn, :correct_entires)

  def initialize(arr)
    @turn = 1
    @arr = arr
    @correct_entires = 0
  end

  def draw_board
    12.times { |i| puts "#{i + 1} #{arr[i]}" }
  end

  def increment_turn
    self.turn += 1
  end

  def code_picker
    code_options = %w[A B C D]
    code = []
    while code.length < 4
      cpu_choice = code_options[rand(4)]
      code << cpu_choice unless code.any? { |ele| ele == cpu_choice }
    end
    code
  end

  def check_for_winner(input, code)
    input.split(' ') == code
  end

  def update_board(input, turn)
    arr[turn - 1] = input.split(' ') << "#{correct_entires} correct entries"
  end

  def feedback(input, code)
    self.correct_entires = 0
    input.split(' ').each_with_index { |entry, index| entry == code[index] ? self.correct_entires += 1 : '' }
  end
end

current_game = Game.new([%w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _],
                         %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _],
                         %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _]])

def playing(current_game)
  code = current_game.code_picker
  current_game.draw_board
  puts "input 'A B C D' in the correct order to crack the code!"
  while current_game.turn <= 12
    puts "Current Turn: #{current_game.turn}"
    input = gets.chomp
    if input.split(' ').all? { |entry| code.include?(entry) }
      current_game.feedback(input, code)
      current_game.update_board(input, current_game.turn)
      current_game.draw_board
      if current_game.check_for_winner(input, code)
        puts 'You Won: You cracked the code!'
        return
      else
        current_game.increment_turn
      end
    else
      puts 'Invalid Input!'
    end

  end
  puts 'Game Over: Turn limit reached!'
end

playing(current_game)
