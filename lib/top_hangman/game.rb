require_relative 'round'
require_relative 'word'

module TopHangman
  class Game
    # attr_reader :base_words

    def initialize
      @word = Word.new
    end

    def start
      game_loop
    end

    def game_loop
      @round = create_round

      @round.start_round
    end

    private

    def create_round
      Round.new(word)
    end
  end
end
