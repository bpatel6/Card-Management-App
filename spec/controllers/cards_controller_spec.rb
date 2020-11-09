require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  describe 'index' do
    it 'successfully collects all card in deck' do
      cards = CardsController.new.index
      expect(cards).to eq(Card.where(pile_id: 0))
    end
  end
end
