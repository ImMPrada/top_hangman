require './spec/spec_helper'

RSpec.describe TopHangman::Game do
  let(:game_wrong_base_file) { described_class.new('wrong_file.txt') }
  let(:game) { described_class.new('google-10000-english-no-swears.txt') }

  describe '#initialize' do
    describe 'when base file is not found' do
      it 'returns nil' do
        expect(game_wrong_base_file.base_words).to be_nil
      end
    end

    describe 'when base file is found' do
      it 'returns array of words' do
        expect(game.base_words).to be_a(Array)
      end
    end
  end
end
