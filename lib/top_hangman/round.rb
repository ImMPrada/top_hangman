require_relative 'render'
require_relative 'guess'

module TopHangman
  class Round
    attr_reader :word

    def initialize(word, render)
      @word = word
      @guess = Guess.new(@word.current_word, render)
      @render = render
    end

    def start_round
      run_round_loop

      return :you_lose if mistakes_limit_reached?

      :you_win
    end

    def run_round_loop
      @render.show_progress(@guess.word_progress, @guess.mistakes_count)

      puts mistakes_limit_reached?
      @guess.run_loop
      run_round_loop unless word_revealed? || mistakes_limit_reached?
    end

    def mistakes_limit_reached?
      @guess.mistakes_count == 7
    end

    def word_revealed?
      @guess.word_progress.join('') == @word.current_word
    end
  end
end
