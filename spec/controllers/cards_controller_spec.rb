require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  describe 'index' do
    it 'successfully collects all card in deck' do
      cards = Card.all
      expect(cards).to eq(Card.all)
    end
  end

  describe 'collecting cards' do
    def setup
      ranks = %w[A 2 3]
      suits = %w[S, D, C, H]
      ranks.each do |rank|
        suits.each do |suit|
          Card.create(card_value: rank, card_suit: suit, pile_id: 666, visible: false)
        end
      end
    end
    it 'successfully collects all card that are in session' do
      setup
      cards = Card.where(pile_id: 666)
      expect(cards.length).to eq(12)
    end

    it 'successfully removes card from database' do
      setup
      card = Card.where(card_value: 'A').where(card_suit: 'D')
      card.each do |i|
        Card.destroy(i)
      end
      expect(Card.where(pile_id: 666).count).to eq(12)
    end
  end
end
