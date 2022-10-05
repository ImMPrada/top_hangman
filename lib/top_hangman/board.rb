module TopHangman
  class Board
    NUMBER_OF_STATES = 7
    FOLDER_NAME = 'lib/hangmans'.freeze

    attr_reader :states

    def initialize
      @states = read_hangman_files
    end

    private

    def read_hangman_files
      hangman_states = {}
      NUMBER_OF_STATES.times { |i| hangman_states[i] = open_file(i) }

      hangman_states
    end

    def open_file(index)
      file = File.open("#{FOLDER_NAME}/state_0#{index}.txt", 'r')
      lines_read = file.readlines.map(&:chomp)
      file.close

      lines_read
    end
  end
end
