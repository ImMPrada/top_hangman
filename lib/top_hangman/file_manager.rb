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

    def save_game(name_tu_use = nil)
      current_game_hash = build_game_for_file(@current_game)
      file_name = name_tu_use || build_file_name
      file = File.open("#{ROOT}#{file_name}", 'w')
      file.write(current_game_hash.to_yaml)
      file.close

      SAVED
    end

    def load_game(file_to_load)
      file = File.open("#{ROOT}#{file_to_load}", 'r')
      game_from_file = YAML.load(file.read)
      file.close

      build_game_from_file(game_from_file)
    end

    private

    def build_file_name
      time = Time.new

      "#{time.year}_#{time.month}_#{time.day}_#{time.hour}_#{time.min}_#{time.sec}.yml"
    end

    def build_game_for_file(game)
      {
        current_round: build_round_for_file(game.current_round),
        state: game.state,
        rounds_history: game.rounds_history.map { |round| build_round_for_file(round) }
      }
    end

    def build_game_from_file(game_from_file)
      current_round = build_round_from_file(game_from_file[:current_round])
      rounds_history = game_from_file[:rounds_history].map { |round| build_round_from_file(round) }

      Game.new(current_round, rounds_history)
    end

    def build_round_for_file(round)
      {
        word: build_word_for_file(round.word),
        guess_history: round.guess_history.map { |guess| bueld_guess_for_file(guess) },
        current_guess: bueld_guess_for_file(round.current_guess),
        errors_count: round.errors_count,
        state: round.state
      }
    end

    def build_round_from_file(round_from_file)
      word = build_word_from_file(round_from_file[:word])
      current_guess = build_guess_from_file(round_from_file[:current_guess], word)
      errors_count = round_from_file[:errors_count]
      guess_history = round_from_file[:guess_history].map { |guess| build_guess_from_file(guess, word) }
      state = round_from_file[:state]

      Round.new(word:, current_guess:, errors_count:, guess_history:, state:)
    end

    def bueld_guess_for_file(guess)
      {
        attempted_letter: guess.attempted_letter
      }
    end

    def build_guess_from_file(build_guess_from_file, word)
      Guess.new(build_guess_from_file[:attempted_letter], word)
    end

    def build_word_for_file(word)
      {
        value: word.value,
        progress: word.progress
      }
    end

    def build_word_from_file(word_from_file)
      Word.new(word_from_file[:value], word_from_file[:progress])
    end
  end
end
