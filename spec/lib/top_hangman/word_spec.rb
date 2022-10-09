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

  describe '#letter_present?' do
    let(:word) { described_class.new(test_string) }
    let(:present_letter) { 'u' }
    let(:absent_letter) { 'z' }

    describe 'when the letter is present' do
      it 'returns true' do
        expect(word.letter_present?(present_letter)).to be(true)
      end
    end

    describe 'when the letter is not present' do
      it 'returns false' do
        expect(word.letter_present?(absent_letter)).to be(false)
      end
    end
  end
end
