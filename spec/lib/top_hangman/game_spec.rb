require './spec/spec_helper'

RSpec.describe TopHangman::Game do
  describe '#initialize' do
    let(:game) { described_class.new }

    it 'sets @word to TopHangman::Word instance' do
      word = game.instance_variable_get(:@word)
      expect(word.class).to be(TopHangman::Word)
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
