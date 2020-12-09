class CardsController < ApplicationController

  def deckoverview
    render partial: "deckoverview"
  end

  def index
    @cards = Card.where(pile_id: 0)
    @discard_card = Card.where(pile_id: 100)
  end

  def deal_all
    # users = User.# get user IDs
    user = 666
    dealnum = Integer(params[:num_cards])

    # loops through each user
    # users.each do |user|

      # loops through the requested number of cards
      i = 0
      while i < dealnum do
        # gets the most updated form of the deck
        deck = Card.where(pile_id: 0)
        # gets a random card
        card = deck[rand(deck.length)]
        # puts that random card in the current user's hand
        card.update(pile_id: user)
        # increments loop counter
        i=i+1
      end
    # end
    flash[:notice] = "You dealt #{dealnum} cards"
    # flash[:notice] = "You dealt #{users.length*dealnum} cards"
    redirect_to cards_path
  end

end