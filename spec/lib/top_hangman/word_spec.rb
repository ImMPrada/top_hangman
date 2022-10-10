require './spec/spec_helper'

RSpec.describe TopHangman::Word do
  let(:test_string) { 'ruby' }

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
