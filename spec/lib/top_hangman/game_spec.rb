require './spec/spec_helper'

RSpec.describe TopHangman::Game do
  let(:game) { described_class.new }

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

  describe '#create_new_round' do
    let(:letter) { 'a' }

    before do
      game.start
      game.play_round(letter)
    end

    it 'creates a Round object in current_round' do
      game.create_new_round
      expect(game.current_round).to be_a(TopHangman::Round)
    end

    it 'adds the current round to the history' do
      old_round = game.current_round
      game.create_new_round
      expect(game.rounds_history).to include(old_round)
    end

    it 'creates a new round' do
      old_round = game.current_round
      game.create_new_round
      expect(game.current_round).not_to be(old_round)
    end
  end
end
