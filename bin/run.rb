require_relative '../config/environment'
require_relative "../bin/api_communicator.rb"
require 'pry'



puts "HELLO WORLD"
get_pokemon_from_api()

binding.pry