require_relative 'round'
require_relative 'word'
require_relative 'guess'

module TopHangman
  class Game
    RUNNING = :running
    STOPPED = :stopped

    attr_reader :current_round, :rounds_history, :state

    def initialize
      @current_round = nil
      @rounds_history = []
      @state = nil
    end

    def start
      @state = RUNNING
      @current_round = Round.new
    end

    def play_round(letter)
      @current_round.create_guess(letter)
      @current_round.update_state
    end

    def create_new_round
      @rounds_history << @current_round
      @current_round = Round.new
    end

    def stop
      @state = STOPPED
    end
  end
end
