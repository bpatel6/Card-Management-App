class SessionsController < ApplicationController
  def new

  end

  def create
    @user = User.from_omniauth(request.env['omniauth.auth'])
    session[:session_token] = @user.session_token
    new_score = Score.new
    new_score.email = @user.email
    new_score.name = @user.name
    new_score.score = 0
    new_score.save!
    redirect_to users_show_path, notice: 'signed in'
  end

  def destroy
    cards = Card.all
    cards.each do |card|
      card.update(pile_id: 0)
    end
    session[:session_token] = nil
    redirect_to root_url, notice: 'signed out'
  end
end
