require_relative '../config/environment'
require_relative './cli.rb'



puts "HELLO WORLD"
cli = CLI.new
cli.welcome
