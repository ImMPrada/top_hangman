require './spec/spec_helper'

RSpec.describe TopHangman::Word do
  let(:word) { described_class.new }

  describe '#initialize' do
    it 'sets @current_word to nil' do
      expect(word.current_word).to be_nil
    end

    it 'sets @history_of_words to nil' do
      history_of_words = word.instance_variable_get(:@history_of_words)
      expect(history_of_words).to be_empty
    end

    it 'sets @base_words to an array of words' do
      base_words = word.instance_variable_get(:@base_words)
      expect(base_words).to be_an(Array)
    end
  end

  describe '#set_current_word' do
    before do
      word.set_current_word
    end

    it 'sets @current_word to a random word' do
      expect(word.current_word).to be_a(String)
    end

    it 'sets @history_of_words to an array of words' do
      history_of_words = word.instance_variable_get(:@history_of_words)
      expect(history_of_words).to be_an(Array)
    end
  end
end
