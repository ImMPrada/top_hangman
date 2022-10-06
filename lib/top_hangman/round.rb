require_relative 'render'
require_relative 'guess'

module TopHangman
  class Round
    attr_reader :word

    def initialize
      @word = Word.from_list
      @guess_history = []
      @word_history = []
      @current_guess = nil
    end

    def create_guess(letter)
      @current_guess = Guess.new(letter, @word)
    end

    def determine_guess_state
      return Guess::REPEATED if @guess.repeated_letter?(@guess_history)

      @guess.validate
    end

    def update_guess_history
      @guess_history << @guess
    end
  end
end
