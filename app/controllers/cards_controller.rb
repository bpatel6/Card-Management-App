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
    deck = Card.where(pile_id: current_user.active_session)
    dealnum = Integer(params[:num_cards])

    if deck.length == 0
      flash[:notice] = "The deck ran out of cards"
      redirect_to users_show_path
    else
      users.each do |user|
        deck = Card.where(pile_id: current_user.active_session)
        # loops through the requested number of cards
        if deck.length == 0
          break
        end
        i = 0
        while i < dealnum do
          if deck.length == 0
            break
          end
          card = deck[rand(deck.length)]
          # puts that random card in the current user's hand
          card.update(pile_id: user.account_id)
          # increments loop counter
          i = i+1
        end
        flash[:notice] = "You dealt #{users.length*i} cards"
      end
      redirect_to users_show_path
    end
  end
end