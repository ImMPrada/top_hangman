require './spec/spec_helper'

RSpec.describe TopHangman::FileManager do
  let(:word) { TopHangman::Word.new('test') }
  let(:round) do
    TopHangman::Round.new(
      word:,
      current_guess: TopHangman::Guess.new('w', word),
      guess_history: [
        TopHangman::Guess.new('t', word),
        TopHangman::Guess.new('e', word)
      ]
    )
  end
  let(:game) { TopHangman::Game.new(round) }
  let(:file_name) { 'testing_file' }
  let(:file_manager) { described_class.new(game) }

  describe '#save_game' do
    it 'saves game to file' do
      file_manager.save_game(file_name)

      expect(File.exist?("#{described_class::ROOT}#{file_name}")).to be true
    end
  end
end
