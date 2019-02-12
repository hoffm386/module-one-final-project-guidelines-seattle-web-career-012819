class CreatePokemonGames < ActiveRecord::Migration 
    def change
        create_table :pokemon_games do |t|
           t.integer :pokemon_id
           t.integer :game_id
        end
    end
end