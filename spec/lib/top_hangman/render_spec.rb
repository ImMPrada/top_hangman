require './spec/spec_helper'

RSpec.describe TopHangman::Render do
  let(:render) { described_class.new }

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
