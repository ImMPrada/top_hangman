require './spec/spec_helper'

RSpec.describe TopHangman::Render do
  let(:render) { described_class.new }

  describe '#initialize' do
    it 'sets @states to a hash of 7 elements' do
      states = render.instance_variable_get(:@states)
      expect(states.size).to be(7)
    end

    it 'sets each value of @states to an array of 14 elements' do
      states = render.instance_variable_get(:@states)
      states.each_value do |value|
        expect(value.size).to be(14)
      end
    end

    it 'sets each value of @states to an array of strings' do
      states = render.instance_variable_get(:@states)
      states.each_value do |value|
        value.all? { |line| expect(line).to be_a(String) }
      end
    end
  end

  describe '#ask_for_guess' do
    let(:input_letter) { 'a' }

    before do
      allow(render).to receive(:gets).and_return("#{input_letter}\n")
    end

    it 'returns a string' do
      expect(render.ask_for_guess).to be_a(String)
    end

    it 'returns inputed string' do
      expect(render.ask_for_guess).to eq(input_letter)
    end
  end
end
