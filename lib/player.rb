require 'colorize'
require_relative 'code'

class Player
  def get_guess
    loop do
      print 'Enter your guess (e.g, red green blue yellow): '
      input = gets.chomp.downcase.split.map(&:to_sym)

      return Code.new(input) if valid_guess?(input)

      puts "Invalid guess. Please enter #{Code::CODE_LENGTH} colors from: #{Code::COLORS.join(', ')}".colorize(:light_red)
    end
  end

  def create_code
    puts "\nCreate a secret code for the computer to guess."

    loop do
      print 'Enter your code (e.g, red green blue yellow): '
      input = gets.chomp.downcase.split.map(&:to_sym)

      return Code.new(input) if valid_guess?(input)

      puts "Invalid code. Please enter #{Code::CODE_LENGTH} colors from: #{Code::COLORS.join(', ')}".colorize(:light_red)
    end
  end

  private

  def valid_guess?(guess)
    guess.size == Code::CODE_LENGTH && guess.all? { |color| Code::COLORS.include?(color) }
  end
end
