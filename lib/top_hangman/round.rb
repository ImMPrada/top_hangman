require_relative 'word'
require_relative 'guess'

module TopHangman
  class Round
    ERRORS_LIMIT = 7
    RUNNING = :running
    STOPPED = :stopped

    WON = :won
    LOST = :lost

    attr_reader :word, :current_guess, :errors_count, :state, :guess_history

    def initialize
      @word = Word.from_list
      @guess_history = []
      @current_guess = nil
      @errors_count = 0
      @state = RUNNING
    end

    def create_guess(letter)
      @current_guess = Guess.new(letter, @word)
    end

    def update_state
      validation_result = @current_guess.validate(@guess_history)

      case validation_result
      when Guess::WRONG
        update_errors_count
        update_guess_history
      when Guess::RIGHT
        update_word_progress
        update_guess_history
      end

      @state = STOPPED if finished?
      @state
    end

    def result
      return unless finished?

      return WON if @word.progress.all?(true)
      return LOST if @errors_count == ERRORS_LIMIT
    end

    private

    def finished?
      @word.progress.all?(true) || @errors_count == ERRORS_LIMIT
    end

    def update_guess_history
      @guess_history << @current_guess
    end

    def update_errors_count
      @errors_count += 1
    end

    def update_word_progress
      @word.update_progress_with(@current_guess.attempted_letter)
    end
  end
end
