class Game < ActiveRecord::Base
  has_many :pokemon_moves
  has_many :pokemons, through: :pokemon_games

  
end
