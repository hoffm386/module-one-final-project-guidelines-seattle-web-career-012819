require_relative '../config/environment'
require_relative "../lib/API/api_communicator.rb"
require_relative "../lib/API/command_line_interface.rb"

#call methods here
CLI = CommandLineInterface.new


#CLI.question_01
CLI.welcome
CLI.author_most_book #call the first question method
CLI.books_by_author #call the second question method
CLI.books_by_publisher #third
CLI.author_of_book #fourth
CLI.usage_class_percentage #fifth

# binding.pry
# 0
