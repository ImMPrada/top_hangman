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

  # describe '#start' do
  #   let(:game) { described_class.new('google-10000-english-no-swears.txt') }
  #   let(:input_letter) { 'a' }

  #   before do
  #     allow(described_class).to receive(:gets).and_return(input_letter)
  #     game.start
  #   end

  #   it 'sets @round to Round class object' do
  #     round = game.instance_variable_get(:@round).class
  #     expect(round).to be(TopHangman::Round)
  #   end
  # end
end
