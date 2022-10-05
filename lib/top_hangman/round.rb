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

    def start_round
      @guess = @render.ask_for_guess

      run_round_loop
    end

    def run_round_loop
      check_guess
      update_guesses_history
    end

    def update_guesses_history
      @guesses << @guess
    end

    private

    def check_guess
      @is_guess_repeated_or_in_word = false
      return @is_guess_repeated_or_in_word = true if @guesses.include?(@guess)

      @word_array.each_with_index do |letter, index|
        next unless letter == @guess

        @word_progress[index] = letter
        @is_guess_repeated_or_in_word = true
      end
    end
  end
end
