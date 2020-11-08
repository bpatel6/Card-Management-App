class UsersController < ApplicationController
  def show
    @hand_cards = Card.all
  end
end
