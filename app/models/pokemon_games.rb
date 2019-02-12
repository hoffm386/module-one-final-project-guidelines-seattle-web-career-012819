class PokemonGame < ActiveRecord::Base 
     belongs_to :pokemon
     belong_to :game

end