require_relative 'render'

module TopHangman
  class Round
    attr_reader :word

    def initialize(word)
      @word = word
      @end_of_round = false
      @guesses = []
      @guess = nil
      @guess_count = 0
      @word_array = word.split('')
      @word_progress = Array.new(@word_array.length, '_')
      @render = Render.new
    end

    def try_guess
      @guess = @render.ask_for_guess
      @guesses << @guess
    end
  end
end
