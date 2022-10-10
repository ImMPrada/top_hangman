require './spec/spec_helper'

RSpec.describe TopHangman::Round do
  let(:round) { described_class.new }

  describe '#crete_guess' do
    it 'creates a new guess' do
      round.create_guess('a')
      expect(round.current_guess).to be_a(TopHangman::Guess)
    end

    it 'sets the guess attempted letter' do
      round.create_guess('a')
      current_guess = round.instance_variable_get(:@current_guess)
      expect(current_guess.attempted_letter).to eq('a')
    end
  end

  describe '#update_state' do
    let(:round_state) { round.state }

    describe 'when the guess is wrong' do
      before do
        round.create_guess('*')
        round.update_state
      end

      it 'updates the errors count' do
        expect(round.errors_count).to eq(1)
      end

      it 'updates the guess history' do
        expect(round.guess_history).to eq([round.current_guess])
      end

      it 'returns the running state' do
        expect(round_state).to eq(described_class::RUNNING)
      end
    end

    describe 'when the guess is right' do
      let(:current_word_string) { round.word.value }

      before do
        round.create_guess(current_word_string[0])
        round.update_state
      end

      it 'updates the word progress' do
        expect(round.word.progress).not_to eq(Array.new(current_word_string.size, false))
      end

      it 'updates the guess history' do
        expect(round.guess_history).to eq([round.current_guess])
      end

      it 'returns the running state' do
        expect(round_state).to eq(described_class::RUNNING)
      end
    end
  end

  describe '#result' do
    let(:current_word_string) { round.word.value }

    describe 'when the round is not finished' do
      it 'returns nil' do
        expect(round.result).to be_nil
      end
    end

    describe 'when the round is finished by completing the word' do
      before do
        current_word_string.each_char do |letter|
          round.create_guess(letter)
          round.update_state
        end
      end

      it 'returns the won result' do
        expect(round.result).to eq(described_class::WON)
      end
    end

    describe 'when the round is finished by reaching the errors limit' do
      before do
        tries_count = 0
        letters = ('a'..'z').to_a
        fake_letters_used_array = []
        until tries_count == described_class::ERRORS_LIMIT
          use_letter = false

          until use_letter
            letter_to_use = letters.sample
            use_letter = !current_word_string.include?(letter_to_use)
            use_letter = !fake_letters_used_array.include?(letter_to_use) if use_letter
            fake_letters_used_array << letter_to_use if use_letter
          end

          round.create_guess(letter_to_use)
          round.update_state
          tries_count += 1
        end
      end

      it 'returns the lost result' do
        expect(round.result).to eq(described_class::LOST)
      end
    end
  end
end
