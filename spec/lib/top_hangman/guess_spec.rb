require './spec/spec_helper'

RSpec.describe TopHangman::Guess do
  let(:word) { TopHangman::Word.new('ruby') }
  let(:present_letter) { 'u' }
  let(:absent_letter) { 'z' }

  describe '#validate' do
    describe 'when the letter is present' do
      let(:guess) { described_class.new(present_letter, word) }

      describe 'when the letter has not been guessed before' do
        let(:guess_history) { [described_class.new('r', word)] }

        it 'returns :right_guess' do
          expect(guess.validate(guess_history)).to eq(described_class::RIGHT)
        end
      end

      describe 'when the letter has been guessed before' do
        let(:guess_history) { [described_class.new(present_letter, word)] }

        it 'returns :repeated_guess' do
          expect(guess.validate(guess_history)).to eq(described_class::REPEATED)
        end
      end
    end

    describe 'when the letter is not present' do
      let(:guess) { described_class.new(absent_letter, word) }

      describe 'when the letter has not been guessed before' do
        let(:guess_history) { [described_class.new('r', word)] }

        it 'returns :wrong_guess' do
          expect(guess.validate(guess_history)).to eq(described_class::WRONG)
        end
      end

      describe 'when the letter has been guessed before' do
        let(:guess_history) { [described_class.new(absent_letter, word)] }

        it 'returns :repeated_guess' do
          expect(guess.validate(guess_history)).to eq(described_class::REPEATED)
        end
      end
    end
  end
end
