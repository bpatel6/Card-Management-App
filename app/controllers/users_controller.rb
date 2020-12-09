class UsersController < ApplicationController

  def user_hand
    #puts(current_user.account_id)
    @hand_cards = Card.where(pile_id: current_user.account_id).sort_by{ |card| card[:card_suit] }
    @visible_cards=Card.where(visible: true).sort_by{|card| card[:pile_id]}
    @visible_users=[]
    @visible_cards.each do |card|
      @visible_users.append(Users.where(account_id: card[:pile_id]))
    end
    render partial: "user_hand"
  end

  def show
    if current_user == nil
      redirect_to cards_path, notice: "You are not logged in, Must log in to view your cards"
    else
      @session_id = Settings.find_by_uid(current_user.uid)
      @current_user_score = Score.find_by(email: current_user.email)
    end
  end

  def draw
    cards = Card.where(pile_id: 0)
    card = cards[rand(cards.length)]
    if card.nil?
      flash[:notice] = 'No card available in the deck'
    else
      card.update(pile_id: current_user.account_id)
      flash[:notice] = "You got #{card.card_value} of #{card.card_suit}"
    end
    #redirect_to users_show_path
  end

  def update
    if params[:commit] == "Discard"
      discard
    elsif params[:commit] == "Send"
      if params[:player_id].empty?
        flash[:notice] = 'Select a player'
        #redirect_to users_show_path
      else
        player = params[:player_id].to_i
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
    #redirect_to users_show_path
  end

  def send_to_player(player)
    if params[:selected_card].present?
      params[:selected_card].keys.each do |card|
        selected_card = Card.find_by_id(card)
        selected_card.update(pile_id: player)
      end
      user = User.find_by_account_id(player)
      flash[:notice] = "Card sent to #{user[:name]} successfully!"
    else
      flash[:notice] = 'No card selected'
    end
    #redirect_to users_show_path
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
    #redirect_to users_show_path
  end

  def decrement_score
    if Score.exists?(email: current_user.email)
      score_update = Score.find_by(email: current_user.email)
      score = score_update[:score]
      score -= 10
      if score.negative?
        score = 0
        flash[:warning] = "Score can not be decremented anymore!\n"
      end
      score_update.update(score: score)
    end
    #redirect_to users_show_path
  end

end
