# frozen_string_literal: true

# game should print a depiction of the mastermind board game on each round
# round should continue until the player wins or runs out of attempts
# each round the amount of correctly placed pins should be displayed along with the amount of incorrect pins
# 12 total rounds
class Game
  attr_accessor(:arr, :turn, :correct_entires, :code)

  def initialize(arr)
    @turn = 1
    @arr = arr
    @correct_entires = 0
    @code = []
  end

  def code_picker
    code_options = %w[A B C D]
    while code.length < 4
      cpu_choice = code_options[rand(4)]
      code << cpu_choice unless code.any? { |ele| ele == cpu_choice }
    end
  end

  def draw_board
    12.times { |i| puts "#{i + 1 > 9 ? "#{i + 1}: " : "#{i + 1}:  "}#{arr[i]}" }
  end

  def validate_input(input)
    input.split(' ').all? { |entry| code.include?(entry) }
  end

  def increment_turn
    self.turn += 1
  end

  def update_board(input, turn)
    self.correct_entires = 0
    input.split(' ').each_with_index { |entry, index| entry == code[index] ? self.correct_entires += 1 : '' }
    arr[turn - 1] = input.split(' ') << "#{correct_entires} correct entries"
    draw_board
  end

  def handle_turn
    while turn <= 12
      puts "CHEAT: The code is #{code}"
      puts "Current Turn: #{turn}"
      input = gets.chomp
      if validate_input(input)
        update_board(input, turn)
        return if check_for_winner(input)
      else
        puts 'Invalid Entry!'
      end
    end
    puts "Game Over: Turn limit reached! The code was #{code}"
  end

  def check_for_winner(input)
    if input.split(' ') == code
      puts 'You Won: You cracked the code!'
      true
    else
      increment_turn
      false
    end
  end
end

def start_game(current_game)
  playing = false
  until playing
    puts "Enter 'Codebreaker' to crack a code or 'Mastermind' to make a code the computer will try to crack."
    input = gets.chomp
    if input == 'Codebreaker'
      playing = true
      codebreaker_game(current_game)
    elsif input == 'Mastermind'
      playing = true
      mastermind_game(current_game)
    else
      puts 'Invalid entry! Try again.'
    end
  end
end

def codebreaker_game(current_game)
  current_game.code_picker
  current_game.draw_board
  puts "input 'A B C D' in the correct order to crack the code! You have 12 Turns."
  current_game.handle_turn
end

def mastermind_game(current_game)
  # code goes here
end

current_game = Game.new([%w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _],
                         %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _],
                         %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _]])

start_game(current_game)
