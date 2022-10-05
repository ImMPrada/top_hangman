require_relative 'round'
require_relative 'word'
require_relative 'render'

module TopHangman
  class Game
    def initialize
      @word = Word.new
      @render = Render.new
    end

    def start
      game_loop
    end

    def game_loop
      @round = create_round

      result_of_round = @round.start_round
      @render.endgame_message(result_of_round)
    end

    private

    def create_round
      @word.set_current_word
      Round.new(@word, @render)
    end
  end
end
