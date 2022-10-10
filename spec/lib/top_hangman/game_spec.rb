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
end
