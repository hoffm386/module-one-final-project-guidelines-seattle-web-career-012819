require_relative '../config/environment'
require_relative "../lib/API/api_communicator.rb"
require_relative "../lib/API/command_line_interface.rb"

#call methods here
CLI = Command_line_interface.new

#CLI.books_by_publisher
CLI.books_by_author
# binding.pry
# 0
