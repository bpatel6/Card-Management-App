class CardsController < ApplicationController

  def index
    @cards = Card.where(pile_id: 0)
    @discard_card = Card.where(pile_id: 100)
  end

end