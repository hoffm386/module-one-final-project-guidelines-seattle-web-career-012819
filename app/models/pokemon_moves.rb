class PokemonMove < ActiveRecord::Base 
    belongs_to :pokemon
    belong_to :move
end