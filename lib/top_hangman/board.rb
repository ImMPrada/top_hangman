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
      NUMBER_OF_STATES.times { |i| hangman_states[i] = open_file(i).readlines.map(&:chomp) }

      hangman_states
    end

    def open_file(index)
      File.open("#{FOLDER_NAME}/state_0#{index}.txt", 'r')
    end
  end
end
