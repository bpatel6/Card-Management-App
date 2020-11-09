require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  describe 'index' do
    it 'successfully collects all card in database' do
      cards = CardsController.new.index
      expect(cards).to eq(Card.all)
    end
  end
end
