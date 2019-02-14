require_relative '../config/environment'

system "rake db:drop"
system "rake db:migrate"
system "rake db:seed"

menu = UserInterface.new(Author.all, Book.all, Publisher.all, BookDeal.all)

menu.greeting
menu.cli_input

# binding.pry

0

