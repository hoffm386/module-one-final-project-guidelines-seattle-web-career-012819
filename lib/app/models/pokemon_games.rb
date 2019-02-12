class PokemonGame < ActiveRecord::Base
     belongs_to :pokemon
     belongs_to :game
end
