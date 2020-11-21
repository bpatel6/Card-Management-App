class UsersController < ApplicationController

  def show
    if current_user == nil
      redirect_to cards_path, notice: "You are not logged in, Must log in to view your cards"
    else
      @current_user_score = Score.find_by(email: current_user.email)
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


  def increment_score
    if current_user == nil
      flash[:notice] = "You are not logged in, Must log in to view your cards"
    else
      if Score.exists?(email: current_user.email)
        score_update = Score.find_by(email: current_user.email)
        score = score_update[:score]
        score += 10
        score_update.update(score: score)
      end
    end
    redirect_to users_show_path
  end

  def decrement_score
    if Score.exists?(email: current_user.email)
      score_update = Score.find_by(email: current_user.email)
      score = score_update[:score]
      score -= 10
      if score < 0
        score = 0
        flash[:warning] = "Score can not be decremented anymore!\n"
      end
      score_update.update(score: score)
    end
    redirect_to users_show_path
  end

end
