class Game < ActiveRecord::Base
    has_many :pokemon, through: :pokemon_games
end