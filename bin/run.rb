require_relative '../config/environment'
require_relative "../lib/API/api_communicator.rb"
require_relative "../lib/API/command_line_interface.rb"

#call methods here
#api_hash_data
c1 = Command_line_interface.new
c1.welcome
c1.user_answer_input

binding.pry
0
