require './spec/spec_helper'

RSpec.describe TopHangman::Word do
  let(:test_string) { 'ruby' }

  describe '#initialize' do
    let(:word) { described_class.new(test_string) }

    it 'sets the value' do
      expect(word.value).to eq(test_string)
    end

    it 'sets the progress' do
      expect(word.progress).to eq(Array.new(test_string.size, false))
    end
  end

  describe '.from_list' do
    let(:word) { described_class.from_list }

    it 'returns a word' do
      expect(word).to be_a(described_class)
    end

    it 'fill the word with a random word' do
      expect(word.value).to be_a(String)
    end

    it 'sets the progress' do
      expect(word.progress).to eq(Array.new(word.value.size, false))
    end
  end

  describe '#update_progress_with' do
    let(:word) { described_class.new(test_string) }

    before { word.update_progress_with('u') }

    it 'updates the progress' do
      expect(word.progress).to eq([false, true, false, false])
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
