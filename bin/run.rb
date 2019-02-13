require_relative '../config/environment'
require_relative "../bin/api_communicator.rb"
require_relative "../bin/cli.rb"
require 'pry'



puts "HELLO WORLD"
# get_pokemon_from_api()
x = CLI.new()
x.welcome
choice = x.options
while choice != 4 
    x.option_answer(choice)
    choice = x.options
end




# binding.pry
