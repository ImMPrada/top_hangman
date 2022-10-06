module TopHangman
  class Render
    NUMBER_OF_STATES = 7
    FOLDER_NAME = 'lib/hangmans'.freeze

    def initialize
      @states = read_hangman_files
    end

    def ask_for_guess
      puts 'Guess a letter:'
      gets.chomp
    end

    def show_wrong_guess_message
      puts 'Wrong guess!'
    end

    def show_repeated_guess_message
      puts 'Repeated guess!'
    end

    def show_correct_guess_message(word_progress)
      puts word_progress.join(' ')
    end

    def endgame_message(result)
      result == :you_win ? puts('You win!') : puts('You lose!')
    end

    def show_progress(word_progress, mistakes_count)
      print_title
      puts @states[mistakes_count]
      puts word_progress.join(' ')
    end

    private

    def print_title
      system 'clear'
      puts '---------------------'
      puts 'HANGMAN'
      puts '---------------------'
    end

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
