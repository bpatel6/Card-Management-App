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


  describe 'deal all' do
    it 'successfully deals cards to all users' do
      # given there are 3 users:
      User.create!(:name=>'Alice', :provider=>'SELT', :uid=>'123', :account_id=>123, :email=>'alice@gmail.com', :encrypted_password=>'null', :session_token=>SecureRandom.base64, :active_session =>1234)
      User.create!(:name=>'Bob', :provider=>'SELT', :uid=>'231', :account_id=>231, :email=>'bob@gmail.com', :encrypted_password=>'null', :session_token=>SecureRandom.base64, :active_session =>1234)
      User.create!(:name=>'Craig', :provider=>'SELT', :uid=>'321', :account_id=>321, :email=>'craig@gmail.com', :encrypted_password=>'null', :session_token=>SecureRandom.base64, :active_session =>1234)

      # given there are at least 9 cards:
      cards=[{:card_value=>'A',:card_suit=>'H',:pile_id=>1234, :visible=>false},
             {:card_value=>'K',:card_suit=>'H',:pile_id=>1234, :visible=>false},
             {:card_value=>'Q',:card_suit=>'H',:pile_id=>1234, :visible=>false},
             {:card_value=>'J',:card_suit=>'H',:pile_id=>1234, :visible=>false},
             {:card_value=>'10',:card_suit=>'H',:pile_id=>1234, :visible=>false},
             {:card_value=>'9',:card_suit=>'H',:pile_id=>1234, :visible=>false},
             {:card_value=>'8',:card_suit=>'H',:pile_id=>1234, :visible=>false},
             {:card_value=>'7',:card_suit=>'H',:pile_id=>1234, :visible=>false},
             {:card_value=>'6',:card_suit=>'H',:pile_id=>1234, :visible=>false},
             {:card_value=>'5',:card_suit=>'H',:pile_id=>1234, :visible=>false},
             {:card_value=>'4',:card_suit=>'H',:pile_id=>1234, :visible=>false},
             {:card_value=>'3',:card_suit=>'H',:pile_id=>1234, :visible=>false},
             {:card_value=>'2',:card_suit=>'H',:pile_id=>1234, :visible=>false}]
      cards.each do |card|
        Card.create!(card)
      end

      # deal 3 cards
      params = ActionController::Parameters.new(num_cards: 3)
      allow(controller).to receive(:current_user) {User.find_by(name: 'Alice')}
      allow(controller).to receive(:params) {params}
      controller.should_receive(:redirect_to).and_return(true)
      controller.deal_all


    # verify that each user has 3 cards
      expect(Card.where(pile_id: 123).count).to eq(3)
      expect(Card.where(pile_id: 231).count).to eq(3)
      expect(Card.where(pile_id: 321).count).to eq(3)
    end
  end
end
