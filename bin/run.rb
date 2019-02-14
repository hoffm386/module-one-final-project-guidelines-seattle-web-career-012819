require_relative '../config/environment'
require_relative "../lib/API/api_communicator.rb"
require_relative "../lib/API/command_line_interface.rb"

#call methods here
CLI = Command_line_interface.new

#CLI.question_01
#CLI.test
CLI.books_by_publisher
# binding.pry
# 0
