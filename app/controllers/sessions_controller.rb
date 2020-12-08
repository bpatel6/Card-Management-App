class SessionsController < ApplicationController
  def new
  end

  def show

  end

  def create
    @user = User.from_omniauth(request.env['omniauth.auth'])
    session[:session_token] = @user.session_token
    new_score = Score.new
    new_score.email = @user.email
    new_score.name = @user.name
    new_score.score = 0
    new_score.save!
    redirect_to sessions_show_path, notice: 'signed in'
  end

  def setSettings
    redirect_to settings_path
  end

  def createSession
    #params[:setting] is obtained sent from a submit tag from /views/settings/index.html.erb
    settingsHash = params[:settings]

    session_id = rand(10 ** 6)
    setting = Settings.new
    if Settings.find_by_session_id(session_id).nil?
      setting.session_id = session_id
    else
      setting.session_id = rand(10 ** 6)
    end
    current_user[:role] = 'owner'
    current_user[:active_session] = session_id
    current_user.save!
    setting.uid = current_user.uid
    setting.num_decks = settingsHash[:num_decks]
    setting.num_players =settingsHash[:num_players]
    setting.deck_settings =settingsHash[:card_options]
    setting.save!
    redirect_to users_show_path, notice: 'Session created successfully, Share session code with others to join'
  end

  def joinSession
    if params[:sessionCode].present?
      code = params[:sessionCode]
      total_user = User.where(active_session: code)
      setting = Settings.find_by_session_id(code)
      if setting.present?
        if total_user.length <= setting.num_players
          current_user[:active_session] = code
          current_user[:role] = 'player'
          current_user.save!
          redirect_to users_show_path, notice: "You joined the session #{code}"
        else
          flash[:notice] = 'no such session exist. try again or create new'
          redirect_to sessions_show_path
        end
      else
        flash[:notice] = 'no such session exist. try again or create new'
        redirect_to sessions_show_path
      end
    else
      redirect_to sessions_show_path, notice: 'invalid input. check session code and try again'
    end
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
