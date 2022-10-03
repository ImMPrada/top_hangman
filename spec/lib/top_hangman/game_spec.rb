require './spec/spec_helper'

RSpec.describe TopHangman::Game do
  describe '#initialize' do
    describe 'when base file is not found' do
      let(:game_wrong_base_file) { described_class.new('wrong_file.txt') }

      it 'returns nil' do
        expect(game_wrong_base_file.base_words).to be_nil
      end

      it 'sets @list_of_words_size to nil' do
        list_of_words_size = game_wrong_base_file.instance_variable_get(:@list_of_words_size)
        expect(list_of_words_size).to be_nil
      end

      it 'sets @history_of_words to empty array' do
        history_of_words = game_wrong_base_file.instance_variable_get(:@history_of_words)
        expect(history_of_words).to be_empty
      end

      it 'sets @round to nil' do
        round = game_wrong_base_file.instance_variable_get(:@round)
        expect(round).to be_nil
      end
    end

    describe 'when base file is found' do
      let(:game) { described_class.new('google-10000-english-no-swears.txt') }

      it 'returns array of words' do
        expect(game.base_words).not_to be_nil
      end

      it 'sets @list_of_words_size to size of base_words' do
        list_of_words_size = game.instance_variable_get(:@list_of_words_size)
        expect(list_of_words_size).to eq(game.base_words.size)
      end

      it 'sets @history_of_words to empty an array of one element' do
        history_of_words = game.instance_variable_get(:@history_of_words)
        expect(history_of_words.size).to be(1)
      end

      it 'sets @round to Round class object' do
        round = game.instance_variable_get(:@round).class
        expect(round).to be(TopHangman::Round)
      end
    end
  end
end
