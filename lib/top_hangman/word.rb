module TopHangman
  class Word
    WORDS_FILE_SOURCE = 'lib/google-10000-english-no-swears.txt'.freeze
    MIN_WORD_SIZE = 5
    MAX_WORD_SIZE = 12

    attr_reader :current_word

    def initialize
      read_words_file(WORDS_FILE_SOURCE)
      @history_of_words = []
      @current_word = nil
    end

    def set_current_word
      @current_word = random_word
      @history_of_words << @current_word
    end

    private

    attr_reader :base_words

    def read_words_file(file_name)
      return nil unless File.exist?(file_name)

      base_file = File.open(file_name, 'r')
      @base_words = base_file.readlines.map(&:chomp).select { |line| valid_word?(line) }
      base_file.close
    end

    def valid_word?(word)
      word.size > MIN_WORD_SIZE && word.size < MAX_WORD_SIZE
    end

    def random_word
      return nil unless base_words

      random_index = rand(0..base_words.size)
      random_word = base_words[random_index]
      base_words.delete_at(random_index)

      random_word
    end
  end
end
