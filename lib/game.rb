require_relative 'player.rb'
require_relative 'computer_guesser.rb'
require_relative 'code.rb'

class Game
  MAX_ROUNDS = 12

  def initialize
    @player = Player.new
    @mode = select_mode
    @rounds_played = 0
  end

  def play
    display_welcome_message

    if @mode == 1
      play_player_guessing
    else
      play_computer_guessing
  end

  private

  def select_mode
    loop do
      puts "\nSelect game mode."
      puts "1. Player guesses the computers code"
      puts "2. Computer guesses the players code"
      print "Enter choice (1 or 2): "
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
    display_round_header

    guess = @player.get_guess
    feedback = @secret_code.evaluate_guess(guess)

    display_feedback(guess, feedback)

    if feedback[:exact] == Code::CODE_LENGTH
      @game_won = true
    end
  end

  def play_computer_round
    display_round_header

    guess = @computer.make_guess
    puts "Computer guesses: #{guess}"

    feedback = @secret_code.evaluate_guess(guess)
    display_feedback(guess, feedback)

    @computer.receive_feedback(feedback)

    if feedback[:exact] == Code::CODE_LENGTH
      @game_won = true
    else
      sleep(1)
    end
  end

  def game_over?
    @game_won || @rounds_played >= MAX_ROUNDS
  end
end
