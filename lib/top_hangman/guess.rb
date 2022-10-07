module TopHangman
  class Guess
    REPEATED = :repeated_guess
    WRONG = :wrong_guess
    RIGHT = :right_guess

    attr_reader :attempted_letter

    def initialize(attempted_letter, word)
      @attempted_letter = attempted_letter
      @word = word
    end

    def validate(guess_history)
      return REPEATED if repeated_letter?(guess_history)

      @word.letter_present?(@attempted_letter) ? RIGHT : WRONG
    end

    def repeated_letter?(history)
      history.any? { |old_guess| old_guess.attempted_letter == @attempted_letter }
    end
  end
end
