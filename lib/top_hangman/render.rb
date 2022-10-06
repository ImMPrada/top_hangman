require 'colorize'
require 'tty-font'

module TopHangman
  class Render
    NUMBER_OF_STATES = 7
    FOLDER_NAME = 'lib/hangmans'.freeze
    H1_FONT = TTY::Font.new(:starwars)
    H3_FONT = TTY::Font.new(:straight)
    TITLE = 'HANGMAN'.freeze

    def initialize
      @states = read_hangman_files
    end

    def ask_for_guess
      puts 'Guess a letter:'
      gets.chomp
    end

    def show_correct_guess_message(word_progress)
      puts word_progress.join(' ')
    end

    def endgame_message(result)
      result == :you_win ? winning_message : losing_message
    end

    def show_progress
      print_title
      print_hangman_state
      print_guess_tries
    end

    def setup_guess(guess)
      @guess = guess
    end

    private

    def print_title
      system 'clear'
      puts H1_FONT.write(TITLE).cyan
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

    def print_hangman_state
      puts @states[[@guess.mistakes_count, 6].min]
      puts ' '
      puts ' '
    end

    def print_guess_tries
      puts @guess.guess_tries.join(' ').yellow
      puts ' '
      puts ['Mistakes counter:'.yellow, @guess.mistakes_count.to_s.red].join(' ')
      puts ' '
      puts @guess.word_progress.join(' ').green
      puts ' '
    end

    def winning_message
      print_title
      print_hangman_state
      puts 'YOU CHOSE WISELY:'.green
      puts @guess.word_progress.join(' ').upcase.green
      puts ' '
      puts ' '
      puts ' '
      puts H1_FONT.write('YOU WIN!').green
    end

    def losing_message
      print_title
      print_hangman_state
      puts 'THE RIGHT WORD WAS:'.red
      puts @guess.word.upcase.red
      puts ' '
      puts ' '
      puts ' '
      puts H1_FONT.write('YOU LOSE!').red
    end
  end
end
