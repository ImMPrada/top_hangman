module TopHangman
  class Word
    WORDS_FILE_SOURCE = 'lib/google-10000-english-no-swears.txt'.freeze
    MIN_WORD_SIZE = 4
    MAX_WORD_SIZE = 13

    @@base_words = nil

    attr_reader :progress, :value

    def initialize(str, progress = nil)
      @value = str
      @progress = progress || Array.new(str.size, false)
    end

    def update_progress_with(letter)
      @value.split('').each_with_index do |char, i|
        @progress[i] = true if char == letter
      end
    end

    def letter_present?(letter)
      @value.include?(letter)
    end

    def self.from_list
      str = pick_random_word
      new(str)
    end

    def self.read_words_file
      return unless File.exist?(WORDS_FILE_SOURCE)

      base_file = File.open(WORDS_FILE_SOURCE, 'r')
      @@base_words = base_file.readlines.map(&:chomp).select { |line| valid_word?(line) }
      base_file.close
    end

    def self.pick_random_word
      read_words_file if @@base_words.nil?

      random_index = rand(0...@@base_words.size)
      random_word = @@base_words[random_index]
      @@base_words.delete_at(random_index)

      random_word
    end

    def self.valid_word?(str)
      str.size > MIN_WORD_SIZE && str.size < MAX_WORD_SIZE
    end

    private_class_method :pick_random_word, :valid_word?, :read_words_file
  end
end
