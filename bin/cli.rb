class CLI

def welcome
   puts "Welcome to Dev Job Hunter! Have you already signed up (y/n)?"
   sign_up_response = gets.chomp
   if sign_up_response == 'y'
     main_menu
   elsif sign_up_response == 'n'
     sign_up
   else
     puts "That's not a valid command"
     return self.welcome
   end
end

def sign_up
  puts "Welcome to Dev Job Hunter!"
  puts "Please enter your name"
  hunter_name = gets.chomp
  puts "Welcome, #{hunter_name}!"
  puts "Please enter the tecnhologies you are fluent in i.e. 'ruby,java,javascript' "
  hunter_tecnhologies = gets.chomp
  puts "Please enter your current location"
  hunter_location = gets.chomp

  #put this here for now to delete previous users
  JobHunter.destroy_all

  JobHunter.find_or_create_by(
    name: hunter_name,
    skills: hunter_tecnhologies,
    location: hunter_location
    )

  puts "Thanks for signing up, #{hunter_name}, you can now search developer jobs!"
end

def main_menu
  puts "What would you like to do?"
  puts "1. Search Developer Jobs"
  puts "2. See Saved Jobs"
  puts "3. Apply for job"

end





end #end of cli class
