require 'colorize'
require 'tty-font'

module TopHangman
  class Renderer
    HANGMAN_STATES_NUMBER = 7
    FOLDER_NAME = 'lib/hangmans'.freeze
    H1_FONT = TTY::Font.new(:starwars)
    H3_FONT = TTY::Font.new(:straight)
    TITLE = 'HANGMAN'.freeze

    def initialize
      @hangman_states = read_hangman_files
    end

    def show_header(errors_count:)
      print_title
      print_hangman_state(errors_count)
    end

    def ask_for_guess
      puts 'Guess a letter:'
    end

    def show_progress(errors_count:, guess_history:, word:)
      show_header(errors_count:)
      print_guess_tries(guess_history, word, errors_count)
    end

    def winning_message(errors_count:, word:)
      show_header(errors_count:)
      puts 'YOU CHOSE WISELY:'.green
      puts ' '
      puts serialize_word(word).upcase.green
      puts ' '
      puts ' '
      puts H1_FONT.write('YOU WIN!').green
      puts 'press enter to continue...'.yellow
    end

    def losing_message(errors_count:, word:)
      show_header(errors_count:)
      puts 'THE RIGHT WORD WAS:'
      puts ' '
      puts word.value.upcase.red
      puts ' '
      puts ' '
      puts H1_FONT.write('YOU LOSE!').red
      puts 'press enter to continue...'.yellow
    end

    def ask_for_new_round
      show_header(errors_count: 0)
      puts H1_FONT.write('WELL  DONE!').cyan
      puts H1_FONT.write('PLAY  AGAIN?').green
      puts 'Y/N'.yellow
    end

    private

    def print_title
      system 'clear'
      puts H1_FONT.write(TITLE).cyan
    end

    def read_hangman_files
      hangman_states = {}
      HANGMAN_STATES_NUMBER.times { |i| hangman_states[i] = open_file(i) }

      hangman_states
    end

    def open_file(index)
      file = File.open("#{FOLDER_NAME}/state_0#{index}.txt", 'r')
      lines_read = file.readlines.map(&:chomp)
      file.close

      lines_read
    end

    def print_hangman_state(errors_count)
      puts @hangman_states[[errors_count, 6].min]
      puts ' '
      puts ' '
    end

    def print_guess_tries(guess_history, word, errors_count)
      puts serialize_guess_history(guess_history)
      puts ' '
      puts ['Mistakes counter:'.yellow, errors_count.to_s.red].join(' ')
      puts ' '
      puts serialize_word(word).green
      puts ' '
    end

    def serialize_guess_history(guess_history)
      guess_history.map(&:attempted_letter).join(' ').yellow
    end

    def serialize_word(word)
      word.progress.each_with_index.map { |asserted, i| asserted ? word.value[i] : '_' }.join(' ')
    end
  end
end
