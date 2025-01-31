# frozen_string_literal: true

# game should print a depiction of the mastermind board game on each round
# round should continue until the player wins or runs out of attempts
# each round the amount of correctly placed pins should be displayed along with the amount of incorrect pins
# 12 total rounds
class Game
  attr_accessor(:arr, :turn, :correct_entires, :mastermind_code, :code_options, :codebreaker_input)

  def initialize(arr)
    @turn = 1
    @arr = arr
    @correct_entires = 0
    @mastermind_code = []
    @code_options = %w[A B C D]
    @codebreaker_input = []
  end

  def generate_mastermind_code
    self.mastermind_code = []
    while mastermind_code.length < 4
      cpu_choice = code_options[rand(4)]
      mastermind_code << cpu_choice unless mastermind_code.any? { |ele| ele == cpu_choice }
    end
  end

  def generate_codebreaker_input
    self.codebreaker_input = []
    while codebreaker_input.length < 4
      cpu_choice = code_options[rand(4)]
      codebreaker_input << cpu_choice unless codebreaker_input.any? { |ele| ele == cpu_choice }
    end
  end

  def draw_board
    12.times { |i| puts "#{i + 1 > 9 ? "#{i + 1}: " : "#{i + 1}:  "}#{arr[i]}" }
  end

  def validate_input
    codebreaker_input.all? { |entry| code_options.include?(entry) }
  end

  def increment_turn
    self.turn += 1
  end

  def update_board
    self.correct_entires = 0
    codebreaker_input.each_with_index do |entry, index|
      entry == mastermind_code[index] ? self.correct_entires += 1 : ''
    end
    arr[turn - 1] = codebreaker_input + ["#{correct_entires} correct entries"]
    draw_board
  end

  def handle_codebreaker_game
    generate_mastermind_code
    while turn <= 12
      self.codebreaker_input = gets.chomp.split(' ')
      if validate_input
        update_board
        return if check_for_winner
      else
        puts 'Invalid Entry!'
      end
    end
    puts "Game Over: Turn limit reached! Mastermind wins! The code was #{mastermind_code}."
  end

  def handle_mastermind_game
    self.mastermind_code = gets.chomp.split(' ')
    if validate_input
      while turn <= 12
        generate_codebreaker_input
        update_board
        return if check_for_winner
      end
      puts "Game Over: Turn limit reached! Mastermind wins! The code was #{mastermind_code}."
    else
      puts 'Invalid Entry!'
    end
  end

  def check_for_winner
    if codebreaker_input == mastermind_code
      puts "Game Over!: Codebreaker cracked the code! The code was #{mastermind_code}."
      true
    else
      # puts "Codebreaker's Input: #{codebreaker_input}  Mastermind's Code: #{mastermind_code}"  # for troubleshooting
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
    input = gets.chomp.downcase
    if input == 'codebreaker'
      playing = true
      codebreaker_game(current_game)
    elsif input == 'mastermind'
      playing = true
      mastermind_game(current_game)
    else
      puts 'Invalid entry! Try again.'
    end
  end
end

def codebreaker_game(current_game)
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
