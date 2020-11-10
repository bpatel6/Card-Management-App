class CardsController < ApplicationController

  def index
    @cards = Card.where(pile_id: 0)
  end

  def deal_all
    puts("Deal_All accessed")
    redirect_to cards_path
  end

end