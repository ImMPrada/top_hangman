module TopHangman
  class IO
    RUNNING = :running
    STOPPED = :stopped

    def initialize
      @state = RUNNING
    end

    def execute(game, renderer, file_manager)
      @file_manager = file_manager
      game.start

      while game.state == Game::RUNNING
        renderer.show_header(errors_count: game.current_round.errors_count)

        while game.current_round.state == TopHangman::Round::RUNNING && @state == RUNNING
          execute_round_loop(renderer, game)
        end

        return unless @state == RUNNING

        show_ending_round_message(renderer, game)
        ask_for_new_round(renderer, game)
      end
    end

    def execute_round_loop(renderer, game)
      renderer.ask_for_guess
      guess_letter = gets.chomp

      return save_game if guess_letter == '--save'
      return load_game(renderer, @file_manager) if guess_letter == '--load'

      game.play_round(guess_letter)
      renderer.show_progress(
        errors_count: game.current_round.errors_count,
        guess_history: game.current_round.guess_history,
        word: game.current_round.word
      )
    end

    def show_ending_round_message(renderer, game)
      case game.current_round.result
      when TopHangman::Round::WON
        renderer.winning_message(
          errors_count: game.current_round.errors_count,
          word: game.current_round.word
        )
      when TopHangman::Round::LOST
        renderer.losing_message(
          errors_count: game.current_round.errors_count,
          word: game.current_round.word
        )
      end
    end

    def ask_for_new_round(renderer, game)
      gets

      renderer.ask_for_new_round
      answer = gets.chomp.upcase

      answer == 'Y' ? game.create_new_round : game.stop
    end

    def save_game
      puts 'save game'
      @state = STOPPED
      @file_manager.save_game
    end

    def load_game(renderer, file_manager)
      puts 'load game'
      game = file_manager.load_game('2022_10_11_12_5_59.yml')
      execute(game, renderer, file_manager)
    end

    private :execute_round_loop, :show_ending_round_message, :ask_for_new_round
  end
end
