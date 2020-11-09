# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   cards = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
cards=[{:card_value=>'1',:card_suit=>'Spades',:pile_id=>0},
       {:card_value=>'2',:card_suit=>'Spades',:pile_id=>0},
       {:card_value=>'3',:card_suit=>'Hearts',:pile_id=>0},
       {:card_value=>'K',:card_suit=>'Diamonds',:pile_id=>0},
       {:card_value=>'Q',:card_suit=>'Clubs',:pile_id=>0},
       {:card_value=>'J',:card_suit=>'Hearts',:pile_id=>0},
       {:card_value=>'6',:card_suit=>'Diamonds',:pile_id=>0}]

cards.each do |card|
  Card.create!(card)
end