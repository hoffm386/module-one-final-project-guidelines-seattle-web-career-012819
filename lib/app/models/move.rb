class Move < ActiveRecord::Base 
    has_many :pokemon, through: :pokemon_moves
end