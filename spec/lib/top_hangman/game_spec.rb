require './spec/spec_helper'

RSpec.describe TopHangman::Game do
  let(:game) { TopHangman::Game.new }

  describe '#start' do
    before { game.start }

    it 'sets the state to running' do
      expect(game.state).to eq(TopHangman::Game::RUNNING)
    end

    it 'creates a new round' do
      expect(game.current_round).to be_a(TopHangman::Round)
    end
  end

  describe '#play_round' do
    let(:letter) { 'a' }

    before do
      game.start
      game.play_round(letter)
    end

    it 'creates a new guess to the current round, with inputed letter' do
      expect(game.current_round.current_guess.attempted_letter).to be(letter)
    end

    it 'updates the state of the current round to running' do
      expect(game.current_round.state).to be(TopHangman::Round::RUNNING)
    end
  end
end
