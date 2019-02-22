require 'rest-client'
require 'json'
require 'pry'


def get_pokemon_from_api(number)
  seed_games
  response_string = RestClient.get("https://pokeapi.co/api/v2/pokemon/?limit=#{number}")
  response_hash = JSON.parse(response_string)
  #Seeding Pokemon
  response_hash["results"].each do |pokemon|
    pokemon_url_string = RestClient.get(pokemon["url"])
    pokemon_url_hash = JSON.parse(pokemon_url_string)
    #creating the pokemon object
    params_hash = {
      name: pokemon["name"].downcase,
      url: pokemon["url"],
      weight: pokemon_url_hash["weight"],
      height: pokemon_url_hash["height"],
      type1: pokemon_url_hash["types"][0]["type"]["name"],
      hp: pokemon_url_hash["stats"].last["base_stat"]
    }
    if (pokemon_url_hash["types"].size == 2)
      params_hash["type2"] = pokemon_url_hash["types"][1]["type"]["name"]
    end
    new_pokemon = Pokemon.find_or_create_by(params_hash)
    #creating the associations for the games
    pokemon_url_hash["game_indices"].each do |x|
      new_pokemon.games << Game.find_or_create_by(name: x["version"]["name"].downcase)
    end
    #creating the moves
    pokemon_url_hash["moves"].each do |m|
      name = m["move"]["name"]
      pokemon_move_string = RestClient.get(m["move"]["url"])
      pokemon_move_hash = JSON.parse(pokemon_move_string)
      new_move = Move.find_or_create_by(
        name: name,
        accuracy: pokemon_move_hash["accuracy"],
        pp: pokemon_move_hash["pp"],
        damage: pokemon_move_hash["power"],
        move_type: pokemon_move_hash["type"]["name"]
      )
      new_pokemon.moves << new_move
    end # end of adding moves

    # reduce down to the default 4 moves per pokemon
    default_moves = new_pokemon.moves.sample(4)
    new_pokemon.moves = default_moves
  end # end of adding pokemon
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

def seed_trainers
  ash = Trainer.create(
    name: "Ash",
    flavor_text: "I'm having a major hat crisis!"
  )
  ash.pokemons = Pokemon.all.sample(6)
  brock = Trainer.create(
    name: "Brock",
    flavor_text: "Hey! I know! I'll use my trusty frying pan as a drying pan!"
  )
  brock.pokemons = Pokemon.all.sample(6)
  misty = Trainer.create(
    name: "Misty",
    flavor_text: "Pikachu! You're a Pika Pal!"
  )
  misty.pokemons = Pokemon.all.sample(6)
  team_rocket = Trainer.create(
    name: "Jessie + James",
    flavor_text: "Prepare for trouble! And make it double! To protect the world from devestation! To Unite all peoples within our nation! To denounce the evils for truth and love! To extend our reach to the stars above! Jessie! James! Team Rocket blasts off at the speed of light! Surrender now, or prepare to fight! Meowth: That's right!"
  )
  team_rocket.pokemons = Pokemon.all.sample(6)
end
