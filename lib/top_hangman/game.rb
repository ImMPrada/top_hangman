require_relative 'round'

module TopHangman
  class Game
    MIN_WORD_SIZE = 5
    MAX_WORD_SIZE = 12

    attr_reader :base_words

    def initialize(file_name)
      @base_words = read_words_file(file_name)
      @list_of_words_size = base_words&.size
      @history_of_words = []
      @round = create_round
    end

    private

    def read_words_file(file_name)
      return nil unless File.exist?(file_name)

      base_file = File.open(file_name, 'r')
      base_file.readlines.map(&:chomp).select { |line| line.size > MIN_WORD_SIZE && line.size < MAX_WORD_SIZE }
    end

    def random_word
      return nil unless base_words

      word = base_words[rand(0..@list_of_words_size)]
      return word unless word_in_history?(word)

      random_word
    end

    def word_in_history?(word)
      @history_of_words.include?(word)
    end

    def add_word_to_history(word)
      @history_of_words << word
    end

    def create_round
      return nil unless base_words || @list_of_words_size == @history_of_words.size

      word = random_word
      add_word_to_history(word)
      Round.new(word)
    end
  end
end
