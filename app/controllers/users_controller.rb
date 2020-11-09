class UsersController < ApplicationController

  def show
    @hand_cards = Card.where(pile_id: 666)
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

  def discard
    if params[:discard_card].present?
      params[:discard_card].keys.each do |card|
        discard_card = Card.find_by_id(card)
        discard_card.update(pile_id: 100)
      end
      flash[:notice] = 'Card discarded successfully!'
    else
      flash[:notice] = 'No card selected'
    end
    redirect_to users_show_path
  end
  
end
