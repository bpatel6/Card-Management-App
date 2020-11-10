class CardsController < ApplicationController

  def index
    @cards = Card.where(pile_id: 0)
  end

  def deal_all

  end

end