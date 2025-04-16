require_relative 'code.rb'

class ComputerGuesser
  def initialize
    @all_possible_codes = Code::COLORS.repeated_permutation(Code::CODE_LENGTH).to_a
    @possible_codes = @all_possible_codes.dup
    @last_guess = nil
  end

  def make_guess
    # Predeterminated guess for the first one
    @last_guess = if @possible_codes.size == @all_possible_codes.size
                    [:red, :red, :green, :green]
                  else
                    @possible_codes.sample
                  end
    Code.new(@last_guess)
  end

  def receive_feedback(feedback)
    @possible_codes.select! do |code|
      temp_code = Code.new(code)
      temp_feedback = temp_code.evaluate_guess(Code.new(@last_guess))
      temp_feedback == feedback
    end
  end
end