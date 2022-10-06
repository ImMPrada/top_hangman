require './spec/spec_helper'

RSpec.describe TopHangman::Guess do
  let(:word) { 'word' }
  let(:render) { TopHangman::Render.new }
  let(:guess) { described_class.new(word, render) }

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

  describe '#try_guess' do
    describe 'when typing wrong guess' do
      let(:input_wrong_letter) { 'k' }
      let(:blank_word_progress) { '____' }

      before do
        repos_response = instance_double(
          TopHangman::Render,
          ask_for_guess: input_wrong_letter
        )
        allow(TopHangman::Render).to receive(:new).and_return(repos_response)
      end

      it 'sets @word_progress to array of underscores' do
        guess.try_guess
        word_progress = guess.instance_variable_get(:@word_progress)
        expect(word_progress.join('')).to eq(blank_word_progress)
      end

      it 'returns :guess_wrong' do
        expect(guess.try_guess).to eq(:guess_wrong)
      end
    end

    describe 'when typing right guess' do
      let(:input_right_letter) { 'o' }
      let(:word_progress_response) { "_#{input_right_letter}__" }

      before do
        repos_response = instance_double(
          TopHangman::Render,
          ask_for_guess: input_right_letter
        )
        allow(TopHangman::Render).to receive(:new).and_return(repos_response)
      end

      it 'sets @current_guess to guess' do
        guess.try_guess
        current_guess = guess.instance_variable_get(:@current_guess)
        expect(current_guess).to eq(input_right_letter)
      end

      it 'sets @guess_tries to array of guess' do
        guess.try_guess
        guess_tries = guess.instance_variable_get(:@guess_tries)
        expect(guess_tries).to eq([input_right_letter])
      end

      it 'sets @word_progress to array of underscores' do
        guess.try_guess
        word_progress = guess.instance_variable_get(:@word_progress)
        expect(word_progress.join('')).to eq(word_progress_response)
      end

      it 'returns :guess_correct' do
        expect(guess.try_guess).to eq(:guess_correct)
      end
    end
  end
end
