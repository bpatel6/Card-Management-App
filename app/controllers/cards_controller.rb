class CardsController < ApplicationController

  def deckoverview
    render partial: "deckoverview"
  end

  def index
    @cards = Card.where(pile_id: current_user.active_session)
    @discard_card = Card.where(pile_id: 1000000 + current_user.active_session)
  end

  def deal_all
    users = User.where(active_session: current_user.active_session)

    dealnum = Integer(params[:num_cards])
    # loops through each user
    users.each do |user|

      # loops through the requested number of cards
      i = 0
      while i < dealnum do
        # gets the most updated form of the deck
        deck = Card.where(pile_id: current_user.active_session)
        # gets a random card
        if deck.length == 0
          flash[:notice] = "The Deck ran Out of Cards"
          break
        end
        card = deck[rand(deck.length)]
        # puts that random card in the current user's hand
        card.update(pile_id: user.account_id)
        # increments loop counter
        i=i+1
      end
      # end
      flash[:notice] = "You dealt #{users.length*dealnum} cards"
    end

  redirect_to users_show_path

  end


end