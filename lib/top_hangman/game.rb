module TopHangman
  attr_reader base_word

  class Game
    def initialize(file_name)
      base_file = File.open(file_name, 'r')
      @base_words = nil unless base_file
      @base_words = base_file.contents
    end
  end
end
