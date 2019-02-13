require 'rest-client'
require 'json'
require 'pry'


def get_pokemon_from_api
seed_games
response_string = RestClient.get('https://pokeapi.co/api/v2/pokemon/?limit=5')
response_hash = JSON.parse(response_string)

response_hash["results"].each do |pokemon|
    pokemon_url_string = RestClient.get(pokemon["url"])
    pokemon_url_hash = JSON.parse(pokemon_url_string)
    if (pokemon_url_hash["types"].size == 1)
      Pokemon.create(name: pokemon["name"].downcase, url: pokemon["url"], weight: pokemon_url_hash["weight"], height: pokemon_url_hash["height"], type1: pokemon_url_hash["types"][0]["type"]["name"])
    else
      Pokemon.create(name: pokemon["name"].downcase, url: pokemon["url"], weight: pokemon_url_hash["weight"], height: pokemon_url_hash["height"], type1: pokemon_url_hash["types"][0]["type"]["name"], type2: pokemon_url_hash["types"][1]["type"]["name"])
    end

    pokemon_url_hash["game_indices"].each do |x|
      # binding.pry
      PokemonGame.create(pokemon_id: Pokemon.last.id, game_id: Game.find_by(name: x["version"]["name"].downcase).id)
    end
    pokemon_url_hash["moves"].each do |m|
      name = m["move"]["name"]
      pokemon_move_string = RestClient.get(m["move"]["url"])
      pokemon_move_hash = JSON.parse(pokemon_move_string)
      # binding.pry
      Move.create(name: name, accuracy: pokemon_move_hash["accuracy"], pp: pokemon_move_hash["pp"], damage: pokemon_move_hash["power"], move_type: pokemon_move_hash["type"]["name"] )
      PokemonMove.create(pokemon_id: Pokemon.last.id, move_id: Move.last.id)
    end
  end
  
end

def seed_games
  Game.create(name: "red", generation: 1, release_date: "1996")
  Game.create(name: "blue", generation: 1, release_date: "1996")
  Game.create(name: "green", generation: 1, release_date: "1996")
  Game.create(name: "yellow", generation: 1, release_date: "1998")
  Game.create(name: "silver", generation: 2, release_date: "1999")
  Game.create(name: "gold", generation: 2, release_date: "1999")
  Game.create(name: "crystal", generation: 1, release_date: "2000")
  Game.create(name: "ruby", generation: 3, release_date: "2002")
  Game.create(name: "sapphire", generation: 3, release_date: "2002")
  Game.create(name: "emerald", generation: 3, release_date: "2004")
  Game.create(name: "firered", generation: 1, release_date: "2004")
  Game.create(name: "leafgreen", generation: 1, release_date: "2004")
  Game.create(name: "diamond", generation: 4, release_date: "2006")
  Game.create(name: "pearl", generation: 4, release_date: "2006")
  Game.create(name: "platinum", generation: 1, release_date: "2008")
  Game.create(name: "heartgold", generation: 2, release_date: "2009")
  Game.create(name: "soulsilver", generation: 2, release_date: "2009")
  Game.create(name: "black", generation: 5, release_date: "2010")
  Game.create(name: "white", generation: 5, release_date: "2010")
  Game.create(name: "black-2", generation: 5, release_date: "2012")
  Game.create(name: "white-2", generation: 5, release_date: "2012")
  Game.create(name: "x", generation: 6, release_date: "2013")
  Game.create(name: "y", generation: 6, release_date: "2013")
  Game.create(name: "omegaruby", generation: 3, release_date: "2014")
  Game.create(name: "alphasaphire", generation: 3, release_date: "2014")
  Game.create(name: "sun", generation: 7, release_date: "2016")
  Game.create(name: "moon", generation: 7, release_date: "2016")
  Game.create(name: "ultrasun", generation: 7, release_date: "2017")
  Game.create(name: "ultramoon", generation: 7, release_date: "2017")
end

