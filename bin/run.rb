require_relative '../config/environment'

system "clear"

print "Please wait. Loading..."

system "rake db:drop"
system "rake db:migrate"
system "rake db:seed"

cli = UserInterface.new()

cli.show_menu

# binding.pry

0
