require './spec/spec_helper'

RSpec.describe TopHangman::Board do
  describe '#initialize' do
    let(:board) { described_class.new }

    it 'sets @states to a hash of 7 elements' do
      expect(board.states.size).to be(7)
    end

    it 'sets each value of @states to an array of 14 elements' do
      board.states.each_value do |value|
        expect(value.size).to be(14)
      end
    end

    it 'sets each value of @states to an array of strings' do
      board.states.each_value do |value|
        value.all? { |line| expect(line).to be_a(String) }
      end
    end
  end
end
