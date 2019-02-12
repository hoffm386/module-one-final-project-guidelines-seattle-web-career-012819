class Pokemon < ActiveRecord::Base 
    has_many :moves, through: :pokemon_moves 
    has_many :games, through: :pokemon_games
end