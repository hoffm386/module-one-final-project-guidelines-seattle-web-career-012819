require 'rest-client'
require 'json'
require 'pry'


def get_pokemon_from_api
response_string = RestClient.get('https://pokeapi.co/api/v2/pokemon/?limit=99')
response_hash = JSON.parse(response_string)

response_hash["results"].each do |pokemon|
    pokemon_url_string = RestClient.get(pokemon["url"])
    pokemon_url_hash = JSON.parse(pokemon_url_string)
    if (pokemon_url_hash["types"].size == 1)
      Pokemon.create(name: pokemon["name"].downcase, url: pokemon["url"], weight: pokemon_url_hash["weight"], height: pokemon_url_hash["height"], type1: pokemon_url_hash["types"][0]["type"]["name"])
    else
      Pokemon.create(name: pokemon["name"].downcase, url: pokemon["url"], weight: pokemon_url_hash["weight"], height: pokemon_url_hash["height"], type1: pokemon_url_hash["types"][0]["type"]["name"], type2: pokemon_url_hash["types"][1]["type"]["name"])
    end

    seed_games
    binding.pry
  end
end

def seed_games
  Game.create(name: "Red", generation: 1, release_date: "1996")
  Game.create(name: "Blue", generation: 1, release_date: "1996")
  Game.create(name: "Green", generation: 1, release_date: "1996")
  Game.create(name: "Yellow", generation: 1, release_date: "1998")
  Game.create(name: "silver", generation: 2, release_date: "1999")
  Game.create(name: "gold", generation: 2, release_date: "1999")
  Game.create(name: "Crystal", generation: 1, release_date: "2000")
  Game.create(name: "Ruby", generation: 3, release_date: "2002")
  Game.create(name: "Saphire", generation: 3, release_date: "2002")
  Game.create(name: "Emerald", generation: 3, release_date: "2004")
  Game.create(name: "Fire Red", generation: 1, release_date: "2004")
  Game.create(name: "Leaf Green", generation: 1, release_date: "2004")
  Game.create(name: "Diamond", generation: 4, release_date: "2006")
  Game.create(name: "Pearl", generation: 4, release_date: "2006")
  Game.create(name: "Platinum", generation: 1, release_date: "2008")
  Game.create(name: "Heart Gold", generation: 2, release_date: "2009")
  Game.create(name: "Soul Silver", generation: 2, release_date: "2009")
  Game.create(name: "Black", generation: 5, release_date: "2010")
  Game.create(name: "White", generation: 5, release_date: "2010")
  Game.create(name: "Black-2", generation: 5, release_date: "2012")
  Game.create(name: "White-2", generation: 5, release_date: "2012")
  Game.create(name: "X", generation: 6, release_date: "2013")
  Game.create(name: "Y", generation: 6, release_date: "2013")
  Game.create(name: "Omega Ruby", generation: 3, release_date: "2014")
  Game.create(name: "Alpha Saphire", generation: 3, release_date: "2014")
  Game.create(name: "Sun", generation: 7, release_date: "2016")
  Game.create(name: "Moon", generation: 7, release_date: "2016")
  Game.create(name: "Ultra Sun", generation: 7, release_date: "2017")
  Game.create(name: "Ultra Moon", generation: 7, release_date: "2017")
  Game.create(name: "Let's Go Pikachu", generation: 7, release_date: "2018")
  Game.create(name: "Let's Go Eevee", generation: 7, release_date: "2018")
end
