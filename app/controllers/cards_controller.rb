class CardsController < ApplicationController

  def index
    @cards = Card.where(pile_id: 0)
  end

end