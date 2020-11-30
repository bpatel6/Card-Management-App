class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings do |t|
      t.string :uid
      t.integer :num_decks
      t.string :num_players
      t.string :deck_settings
      t.string :session_token
    end
  end
end
