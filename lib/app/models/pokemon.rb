class Pokemon < ActiveRecord::Base
    has_many :pokemon_games
    has_many :pokemon_moves
    has_many :moves, through: :pokemon_moves
    has_many :games, through: :pokemon_games

    def print
      str = ""
      str += "Name: #{self.name}\n"
      str += "Height: #{self.height}\n"
      str += "Weight: #{self.weight}\n"
      str+= "Type 1: #{self.type1}\n"

      if self.type2 != nil
        str+= "Type 2: #{self.type2}\n"
      end

      str+= "URL: #{self.url}\n"

      str+= "Appears in: #{self.games.collect {|game| game["name"].capitalize}.join(", ")}"
      # binding.pry

      str
    end
end
