# frozen_string_literal: true

# game should print a depiction of the mastermind board game on each round
# round should continue until the player wins or runs out of attempts
# each round the amount of correctly placed pins should be displayed along with the amount of incorrect pins
# 12 total rounds
class Game
  attr_accessor(:arr, :turn, :correct_entires, :code, :code_options, :user_input)

  def initialize(arr)
    @turn = 1
    @arr = arr
    @correct_entires = 0
    @code = []
    @code_options = %w[A B C D]
    @user_input = []
  end

  def code_picker
    while code.length < 4
      cpu_choice = code_options[rand(4)]
      code << cpu_choice unless code.any? { |ele| ele == cpu_choice }
    end
  end

  def draw_board
    12.times { |i| puts "#{i + 1 > 9 ? "#{i + 1}: " : "#{i + 1}:  "}#{arr[i]}" }
  end

  def validate_input
    user_input.all? { |entry| code_options.include?(entry) }
  end

  def increment_turn
    self.turn += 1
  end

  def update_board
    self.correct_entires = 0
    user_input.each_with_index { |entry, index| entry == code[index] ? self.correct_entires += 1 : '' }
    arr[turn - 1] = user_input + ["#{correct_entires} correct entries"]
    draw_board
  end

  def handle_codebreaker_game
    while turn <= 12
      self.user_input = gets.chomp.split(' ')
      if validate_input
        update_board
        return if check_for_winner
      else
        puts 'Invalid Entry!'
      end
    end
    puts "Game Over: Turn limit reached! Mastermind wins! The code was #{code}."
  end

  def handle_mastermind_game
    self.code = gets.chomp.split(' ')
    if validate_input
      while turn <= 12
        self.code = []
        code_picker
        update_board
        return if check_for_winner
      end
      puts "Game Over: Turn limit reached! Mastermind wins! The code was #{code}."
    else
      puts 'Invalid Entry!'
    end
  end

  def check_for_winner
    if user_input == code
      puts 'You Won: Codebreaker cracked the code!'
      true
    else
      puts "#{user_input} #{code}"
      puts "#{user_input == code}"
      increment_turn
      puts "Current Turn: #{turn}"
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
  current_game.handle_codebreaker_game
end

def mastermind_game(current_game)
  current_game.draw_board
  puts "input 'A B C D' in any order to make the code! The computer has 12 Turns to guess it."
  current_game.handle_mastermind_game
end

current_game = Game.new([%w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _],
                         %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _],
                         %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _]])

start_game(current_game)
