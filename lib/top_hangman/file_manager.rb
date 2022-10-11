require 'yaml'

module TopHangman
  class FileManager
    ROOT = 'bin/games/'.freeze
    SAVED = :saved

    def initialize(game)
      @saved_games = nil
      @selected_game = nil
      @current_game = game
    end

    def list_all_saved_games
      @saved_games = Dir["#{ROOT}*"].map { |file| File.basename(file) }
    end

    def select_game(number)
      @selected_game = @saved_games[number - 1]
    end

    def save_game
      current_game_hash = build_game(@current_game)
      file = File.open("#{ROOT}#{build_file_name}", 'w')
      file.write(current_game_hash.to_yaml)
      file.close

      SAVED
    end

    private

    def build_file_name
      time = Time.new

      "#{time.year}_#{time.month}_#{time.day}_#{time.hour}_#{time.min}_#{time.sec}.yml"
    end

    def build_game(game)
      {
        current_round: build_round(game.current_round),
        state: game.state,
        rounds_history: game.rounds_history.map { |round| build_round(round) }
      }
    end

    def build_round(round)
      {
        word: build_word(round.word),
        guess_history: round.guess_history.map { |guess| build_guess(guess) },
        current_guess: build_guess(round.current_guess),
        errors_count: round.errors_count,
        state: round.state
      }
    end

    def build_guess(guess)
      {
        attempted_letter: guess.attempted_letter
      }
    end

    def build_word(word)
      {
        value: word.value,
        progress: word.progress
      }
    end
  end
end
