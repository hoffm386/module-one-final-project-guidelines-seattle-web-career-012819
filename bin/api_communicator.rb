require 'rest-client'
require 'json'
require 'pry'


def get_pokemon_from_api
response_string = RestClient.get('https://pokeapi.co/api/v2/pokemon/?limit=99')
response_hash = JSON.parse(response_string)

response_hash["results"].each do |pokemon|
    pokemon_url_string = RestClient.get(pokemon["url"])
    pokemon_url_hash = JSON.parse(pokemon_url_string)
    Pokemon.create(name: pokemon["name"].downcase, url: pokemon["url"], weight: pokemon["weight"], height: pokemon["height"], type1: pokemon[:type][0])
    if pokemon["type"].size > 1
            Pokemon.create(name: pokemon["name"].downcase, url: pokemon["url"], weight: pokemon["weight"], height: pokemon["height"], type1: pokemon[:type][0], :type2 pokemon[:type][1])


end

binding.pry
end