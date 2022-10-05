require './spec/spec_helper'

RSpec.describe TopHangman::Guess do
  let(:word) { 'word' }
  let(:guess) { described_class.new(word) }

  describe '#initialize' do
    it 'returns Guess class object' do
      expect(guess).to be_a(described_class)
    end

    it 'sets @word to word' do
      word = guess.instance_variable_get(:@word)
      expect(word).to eq(word)
    end

    it 'sets @guess_tries to empty array' do
      guess_tries = guess.instance_variable_get(:@guess_tries)
      expect(guess_tries).to be_empty
    end

    it 'sets @current_guess to nil' do
      current_guess = guess.instance_variable_get(:@current_guess)
      expect(current_guess).to be_nil
    end

    it 'sets @mistakes_count to 0' do
      mistakes_count = guess.instance_variable_get(:@mistakes_count)
      expect(mistakes_count).to eq(0)
    end

    it 'sets @word_array to array of word' do
      word_array = guess.instance_variable_get(:@word_array)
      expect(word_array).to eq(word.split(''))
    end

    it 'sets @word_progress to array of underscores' do
      word_progress = guess.instance_variable_get(:@word_progress)
      expect(word_progress).to eq(Array.new(word.length, '_'))
    end
  end
end
