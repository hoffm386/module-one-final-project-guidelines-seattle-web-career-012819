require_relative '../config/environment'
require_relative "../bin/api_communicator.rb"
require_relative "../bin/cli.rb"
require 'pry'


x = CLI.new()
x.run






binding.pry
