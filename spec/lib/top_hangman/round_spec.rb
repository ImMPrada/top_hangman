require './spec/spec_helper'

RSpec.describe TopHangman::Round do
  let(:word) { 'word' }
  let(:round) { described_class.new(word) }

  describe '#initialize' do
    it 'returns Round class object' do
      expect(round).to be_a(described_class)
    end

    it 'sets @word to word' do
      expect(round.word).to eq(word)
    end
  end
end
