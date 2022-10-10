require './spec/spec_helper'

RSpec.describe TopHangman::Round do
  let(:round) { described_class.new }

  before do
    word_instance = instance_double(
      TopHangman::Word,
      value: 'ruby',
      progress: Array.new('ruby'.size, false)
    )
    allow(TopHangman::Word).to receive(:from_list).and_return(word_instance)
  end

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
end
