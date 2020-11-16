class CardsController < ApplicationController

  def index
    @cards = Card.where(pile_id: 0)
    @discard_card = Card.where(pile_id: 100)
  end

  def deal_all
    puts(params[:num_cards])
    deck = Card.where(pile_id: 0)
    cards = []
    # users = User.# get user IDs
    user = 666
    dealnum = Integer(params[:num_cards])

    # users.each do |user|
      i = 0
      while i < dealnum do
        card = deck[rand(deck.length)]
        card.update(pile_id: user)
        i=i+1
      end
    # end
    flash[:notice] = "You dealt #{user.length*:num_cards} cards"
    redirect_to cards_path
  end

end