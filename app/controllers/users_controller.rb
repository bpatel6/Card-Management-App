class UsersController < ApplicationController

  def show
    if current_user == nil
      redirect_to cards_path, notice: "You are not logged in, Must log in to view your cards"
    else
      @hand_cards = Card.where(pile_id: current_user.id).sort_by{ |card| card[:card_suit]}
    end
  end

  def draw
    cards = Card.where(pile_id: 0)
    card = cards[rand(cards.length)]
    if card.nil?
      flash[:notice] = 'No card available in the deck'
    else
      card.update(pile_id: current_user.id)
      flash[:notice] = "You got #{card.card_value} of #{card.card_suit}"
    end
    redirect_to users_show_path
  end

  def update
    if params[:commit] == "Discard"
      discard
    elsif params[:commit] == "Send"
      if params[:player_id].empty?
        flash[:notice] = 'Select a player'
        redirect_to users_show_path
      else
        player = params[:player_id]
        send_to_player(player)
      end
    end
  end

  def discard
    if params[:selected_card].present?
      params[:selected_card].keys.each do |card|
        selected_card = Card.find_by_id(card)
        selected_card.update(pile_id: 100)
      end
      flash[:notice] = 'Card discarded successfully!'
    else
      flash[:notice] = 'No card selected'
    end
    redirect_to users_show_path
  end

  def send_to_player(player)
    if params[:selected_card].present?
      params[:selected_card].keys.each do |card|
        selected_card = Card.find_by_id(card)
        selected_card.update(pile_id: player)
      end
      user = User.find_by_id(player)
      flash[:notice] = "Card sent to #{user[:name]} successfully!"
    else
      flash[:notice] = 'No card selected'
    end
    redirect_to users_show_path
  end

end
