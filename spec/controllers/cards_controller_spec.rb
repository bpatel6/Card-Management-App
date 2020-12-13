require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  describe 'index' do
    it 'successfully collects all card in deck' do
      cards = CardsController.new.index
      expect(cards).to eq(Card.where(pile_id: 0))
    end
  end

  describe 'deal all' do
    it 'successfully deals cards to all users' do
      # given there are 3 users:
      User.create!(:name=>'Alice', :provider=>'SELT', :uid=>'123', :account_id=>123, :email=>'alice@gmail.com', :encrypted_password=>'null', :session_token=>SecureRandom.base64)
      User.create!(:name=>'Bob', :provider=>'SELT', :uid=>'231', :account_id=>231, :email=>'bob@gmail.com', :encrypted_password=>'null', :session_token=>SecureRandom.base64)
      User.create!(:name=>'Craig', :provider=>'SELT', :uid=>'321', :account_id=>321, :email=>'craig@gmail.com', :encrypted_password=>'null', :session_token=>SecureRandom.base64)

      # given there are at least 9 cards:
      cards=[{:card_value=>'A',:card_suit=>'H',:pile_id=>0, :visible=>false},
             {:card_value=>'K',:card_suit=>'H',:pile_id=>0, :visible=>false},
             {:card_value=>'Q',:card_suit=>'H',:pile_id=>0, :visible=>false},
             {:card_value=>'J',:card_suit=>'H',:pile_id=>0, :visible=>false},
             {:card_value=>'10',:card_suit=>'H',:pile_id=>0, :visible=>false},
             {:card_value=>'9',:card_suit=>'H',:pile_id=>0, :visible=>false},
             {:card_value=>'8',:card_suit=>'H',:pile_id=>0, :visible=>false},
             {:card_value=>'7',:card_suit=>'H',:pile_id=>0, :visible=>false},
             {:card_value=>'6',:card_suit=>'H',:pile_id=>0, :visible=>false},
             {:card_value=>'5',:card_suit=>'H',:pile_id=>0, :visible=>false},
             {:card_value=>'4',:card_suit=>'H',:pile_id=>0, :visible=>false},
             {:card_value=>'3',:card_suit=>'H',:pile_id=>0, :visible=>false},
             {:card_value=>'2',:card_suit=>'H',:pile_id=>0, :visible=>false}]
      cards.each do |card|
        Card.create!(card)
      end

      # deal 3 cards
      params = ActionController::Parameters.new(num_cards: 3)
      redirect_to cards_deal_all_path
    end
    it 'user1 has 3 cards' do

    # verify that each user has 3 cards
      newcards = Card.where(pile_id: 123)
      newcards.each do |card|
        puts card
      end
      expect(newcards.count).to eq(3)
    end

    it 'user1 has 3 cards' do

    newcards = Card.where(pile_id: 231)

      expect(newcards.count).to eq(3)
    end

    it 'user1 has 3 cards' do
    newcards = Card.where(pile_id: 321)
      expect(newcards.count).to eq(3)
    end
  end
end
