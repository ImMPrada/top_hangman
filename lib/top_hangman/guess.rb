require_relative 'render'

module TopHangman
  class Guess
    attr_reader :word, :mistakes_count, :word_progress

    def initialize(word, render)
      @guess_tries = []
      @current_guess = nil
      @mistakes_count = 0
      @word_array = word.split('')
      @word_progress = Array.new(@word_array.length, '_')
      @render = render
    end

    def try_guess
      @current_guess = @render.ask_for_guess
      check_guess
    end

    def run_loop
      check_response_code = try_guess

      show_guess_try_message(check_response_code)
      check_response_code
    end

    private

    attr_reader :current_guess

    def guess_repeated?
      @guess_tries.include?(current_guess)
    end

    def check_guess
      return :repeated_guess if guess_repeated?

      response_code = :guess_wrong
      @guess_tries << @current_guess

      @word_array.each_with_index do |letter, index|
        next unless letter == current_guess

        @word_progress[index] = letter
        response_code = :guess_correct
      end

      response_code
    end

    def show_guess_try_message(check_response_code)
      case check_response_code
      when :repeated_guess
        @render.show_repeated_guess_message
      when :guess_wrong
        @render.show_wrong_guess_message
        @mistakes_count += 1
      when :guess_correct
        @render.show_correct_guess_message(@word_progress)
      end
    end
  end
end
