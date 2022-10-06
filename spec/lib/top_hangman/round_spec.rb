require './spec/spec_helper'

RSpec.describe TopHangman::Round do
  let(:word) { TopHangman::Word.new }
  let(:render) { TopHangman::Render.new }
  let(:round) { described_class.new(word, render) }

  describe '#initialize' do
    before do
      word.set_current_word
    end

    it 'returns Round class object' do
      expect(round).to be_a(described_class)
    end

    it 'sets @word to word' do
      word = round.instance_variable_get(:@word)
      expect(word).to eq(word)
    end
  end
end
