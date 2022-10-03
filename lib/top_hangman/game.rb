module TopHangman
  class Game
    attr_reader :base_words

    def initialize(file_name)
      @base_words = read_words_file(file_name)
    end

    private

    def read_words_file(file_name)
      return nil unless File.exist?(file_name)

      base_file = File.open(file_name, 'r')
      base_file.readlines.map(&:chomp)
    end
  end
end
