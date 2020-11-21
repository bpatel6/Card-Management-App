class UsersController < ApplicationController

  def show
    if current_user == nil
      redirect_to cards_path, notice: "You are not logged in, Must log in to view your cards"
    else
      @current_user_score = Score.find_by(name: current_user.name)
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
      if Score.exists?(name: current_user.name)
        scoreUpdate = Score.find_by(name: current_user.name)
        score = scoreUpdate[:score]
        score += 10
        scoreUpdate.update(score: score)
      else
        newScore = Score.new
        newScore.uid = current_user.id
        newScore.name = current_user.name
        newScore.score = @current_user_score
        @current_user_score = 0
        newScore.save!
      end
    redirect_to users_show_path
  end
end

