class Pokemon < ActiveRecord::Base
    has_many :pokemon_games
    has_many :pokemon_moves
    has_many :moves, through: :pokemon_moves
    has_many :games, through: :pokemon_games

    def print
      str = ""
      str += "Name: #{self.name.capitalize}\n"
      str+= "HP: #{self.hp}\n"
      str += "Height: #{self.height}\"\n"
      str += "Weight: #{self.weight}lbs\n"
      str+= "Type 1: #{self.type1.capitalize}\n"

      if self.type2 != nil
        str+= "Type 2: #{self.type2.capitalize}\n"
      end

      str+= "URL: #{self.url}\n"
      str+= "Appears in: #{self.games.collect {|game| game["name"].capitalize}.join(", ")}"
      str
    end
end
