module TopHangman
  class Round
    attr_reader :word

    def initialize(word)
      @word = word
    end
  end
end
