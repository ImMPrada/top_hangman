module TopHangman
  class IO
    class << self
      def execute(game, renderer)
        game.start
        renderer.show_header(errors_count: game.current_round.errors_count)

        while game.current_round.state == TopHangman::Round::RUNNING
          renderer.ask_for_guess
          guess_letter = gets.chomp
          game.play_round(guess_letter)
          renderer.show_progress(
            errors_count: game.current_round.errors_count,
            guess_history: game.current_round.guess_history,
            word: game.current_round.word
          )
        end

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
    end
  end
end
