require 'colorize'

class Code
  COLORS = %i[red green yellow magenta blue cyan].freeze
  CODE_LENGTH = 4

  attr_reader :value

  def initialize(value = nil)
    @value = value || generate_random_code
  end

  def self.color_options
    COLORS.map { |c| c.to_s.colorize(c) }.join(', ')
  end

  def evaluate_guess(guess)
    exact_matches = 0
    color_matches = 0

    secret_remaining = @value.dup
    guess_remaining = guess.value.dup

    # Check exact matches
    CODE_LENGTH.times do |i|
      next unless guess.value[i] == @value[i]

      exact_matches += 1
      secret_remaining[i] = nil
      guess_remaining[i] = nil
    end

    # Check color matches (right color, wrong position)
    guess_remaining.compact.each do |color|
      if secret_remaining.include?(color)
        color_matches += 1
        secret_remaining[secret_remaining.index(color)] = nil
      end
    end
    { exact: exact_matches, color: color_matches }
  end

  def to_s
    @value.map { |color| '● '.colorize(color) }.join
  end

  private

  def generate_random_code
    CODE_LENGTH.times.map { COLORS.sample }
  end
end
