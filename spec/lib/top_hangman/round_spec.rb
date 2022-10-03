require './spec/spec_helper'

RSpec.describe TopHangman::Round do
  let(:word) { 'word' }
  let(:round) { described_class.new(word) }

  describe '#initialize' do
    it 'returns Round class object' do
      expect(round).to be_a(described_class)
    end

    it 'sets @word to word' do
      word = round.instance_variable_get(:@word)
      expect(word).to eq(word)
    end

    it 'sets @end_of_round to false' do
      end_of_round = round.instance_variable_get(:@end_of_round)
      expect(end_of_round).to eq(false)
    end

    it 'sets @guesses to empty array' do
      guesses = round.instance_variable_get(:@guesses)
      expect(guesses).to eq([])
    end

    it 'sets @guess to nil' do
      guess = round.instance_variable_get(:@guess)
      expect(guess).to eq(nil)
    end

    it 'sets @guess_count to 0' do
      guess_count = round.instance_variable_get(:@guess_count)
      expect(guess_count).to eq(0)
    end

    it 'sets @word_array to array of word' do
      word_array = round.instance_variable_get(:@word_array)
      expect(word_array).to eq(word.split(''))
    end

    it 'sets @word_progress to array of underscores' do
      word_progress = round.instance_variable_get(:@word_progress)
      expect(word_progress).to eq(Array.new(word.length, '_'))
    end
  end
end
