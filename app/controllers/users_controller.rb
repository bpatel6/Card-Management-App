class UsersController < ApplicationController

  def show
    @hand_cards = Card.where(pile_id: 666).sort_by{ |card| card[:card_suit]}
  end

  def draw
    cards = Card.where(pile_id: 0)
    card = cards[rand(cards.length)]
    if card.nil?
      flash[:notice] = 'No card available in the deck'
    else
      card.update(pile_id: 666)
      flash[:notice] = "You got #{card.card_value} of #{card.card_suit}"
    end
    redirect_to users_show_path
  end
  
end
