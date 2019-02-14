require_relative '../config/environment'

menu = UserInterface.new(Author.all, Book.all, Publisher.all, BookDeal.all)

menu.greeting
menu.cli_input

# binding.pry

0

