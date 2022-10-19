module TopHangman
  class IO
    def execute(game, renderer, file_manager)
      game.start

      while game.running?
        renderer.show_header(errors_count: game.current_round.errors_count)

        execute_round_loop(renderer, game, file_manager) while game.current_round.running?

        return unless game.running?

        show_ending_round_message(renderer, game)
        ask_for_new_round(renderer, game)
      end
    end

    private

    def execute_round_loop(renderer, game, file_manager)
      renderer.ask_for_prompt
      new_prompt = gets.chomp

      return save_game(game, file_manager) if new_prompt == '--save'
      return load_game(renderer, file_manager) if new_prompt == '--load'

      game.play_round(new_prompt)
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

    def save_game(game, file_manager)
      puts 'save game'
      game.stop
      file_manager.save_game
    end

    def load_game(renderer, file_manager)
      renderer.show_files_list(file_manager.list_all_saved_games)
      game_index = gets.chomp.to_i

      game = file_manager.load_game(file_manager.select_game(game_index))
      execute(game, renderer, file_manager)
    end
  end
end
