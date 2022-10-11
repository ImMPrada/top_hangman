require './spec/spec_helper'

RSpec.describe TopHangman::FileManager do
  let(:word) { TopHangman::Word.new('test') }
  let(:game) do
    TopHangman::Game.new(
      TopHangman::Round.new(
        word:,
        current_guess: TopHangman::Guess.new('w', word),
        guess_history: [
          TopHangman::Guess.new('t', word),
          TopHangman::Guess.new('e', word)
        ]
      )
    )
  end
  let(:file_name) { 'testing_file.yml' }
  let(:file_manager) { described_class.new(game) }

  describe '#save_game' do
    it 'saves game to file' do
      file_manager.save_game(file_name)

      expect(File.exist?("#{described_class::ROOT}#{file_name}")).to be(true)
    end
  end

  describe '#load_game' do
    let(:loaded_game) { file_manager.load_game(file_name) }

    before { file_manager.save_game(file_name) }

    it 'loads game from file' do
      expectation = [
        loaded_game.current_round.word.value == game.current_round.word.value,
        loaded_game.current_round.word.progress == game.current_round.word.progress
      ]

      expect(expectation.all?(true)).to be(true)
    end
  end
end
