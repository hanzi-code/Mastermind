require 'colorize'
require_relative 'code.rb'

class Displayer
  def show_welcome_message
    puts "Welcome to Mastermind!".colorize(:light_blue).bold
    puts "Available colors: #{Code.color_options}"
  end

  def show_round_header(current_round, max_rounds)
    puts "\nRounds #{current_round} of #{max_rounds}".colorize(:light_cyan).underline
  end

  def show_feedback(guess, exact_matches, color_matches)
    print "Feedback for #{guess.to_s}: "
    print "● " * exact_matches if exact_matches > 0
    print "○ " * color_matches if color_matches > 0
    puts ""
  end

  def show_game_over_message(won:, rounds_played:, max_rounds:, secret_code:, mode:)
    if won
      winner = mode == 1 ? "Player" : "Computer"
      puts "\n#{winner} wins!".colorize(:green).bold
      puts "The code was broken in #{rounds_played} rounds!".colorize(:green)
    else
      puts "\nGame Over".colorize(:red).bold
      puts "The code wasn't broken in #{max_rounds} rounds.".colorize(:red)
    end
    puts "The secret code was: #{secret_code}\n" unless mode == 1 && won
  end

  def show_mode_menu
    puts "\nSelect game mode."
    puts "1. Player guesses the computers code"
    puts "2. Computer guesses the players code"
    print "Enter choice (1 or 2): "
  end

  def show_computer_guess(guess)
    puts "Computer guesses: #{guess}"
  end
end
