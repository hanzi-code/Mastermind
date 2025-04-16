require 'colorize'
require_relative 'player.rb'
require_relative 'computer_guesser.rb'
require_relative 'code.rb'
require_relative 'displayer.rb'

class Game
  MAX_ROUNDS = 12

  def initialize
    @player = Player.new
    @displayer = Displayer.new
    @mode = select_mode
    @rounds_played = 0
  end

  def play
    @displayer.show_welcome_message

    if @mode == 1
      play_player_guessing
    else
      play_computer_guessing
    end
  end

  private

  def select_mode
    loop do
      @displayer.show_mode_menu
      choice = gets.chomp
      return choice.to_i if ["1", "2"].include?(choice)
      puts "Invalid choice.".colorize(:light_red)
    end
  end

  def play_player_guessing
    @secret_code = Code.new
    puts "\nComputer has generated a secret code. Start guessing!"

    until game_over?
      @rounds_played += 1
      play_player_round
    end
    display_game_over_message
  end

  def play_computer_guessing
    def initialize
      @secret_code = @player.create_code
      @computer = ComputerGuesser.new
      puts "\nComputer will now try to guess your code..."
    end

    until game_over?
      @rounds_played += 1
      play_computer_round
    end
    display_game_over_message
  end

  def play_player_round
    @displayer.show_round_header(@rounds_played, MAX_ROUNDS)
    guess = @player.get_guess

    feedback = @secret_code.evaluate_guess(guess)

    @displayer.show_feedback(guess, feedback[:exact], feedback[:color])
    @game_won = true if feedback[:exact] == Code::CODE_LENGTH
  end

  def play_computer_round
    @displayer.show_round_header(@rounds_played, MAX_ROUNDS)
    guess = @computer.make_guess

    @displayer.show_computer_guess(guess)
    feedback = @secret_code.evaluate_guess(guess)

    @displayer.show_feedback(guess, feedback[:exact], feedback[:color])
    @computer.receive_feedback(feedback)

    @game_won = true if feedback[:exact] == Code::CODE_LENGTH
    sleep(1) unless @game_won
  end

  def display_game_over_message
    @displayer.show_game_over_message(
      won: @game_won,
      rounds_played: @rounds_played,
      max_rounds: MAX_ROUNDS,
      secret_code: @secret_code,
      mode: @mode
    )
  end

  def game_over?
    @game_won || @rounds_played >= MAX_ROUNDS
  end
end
