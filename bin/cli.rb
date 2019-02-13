
@@pokedex_array = []

def welcome
    puts "Welcome to Alpha Super Utra Purple!"
end

def options
    puts "Choose an option"
    puts "1. Catch a Pokemon"
    puts "2. Pokedex"
    puts "3. Statistics"
    puts "4. Exit"
    answer = gets.chomp
end


def option_answer(answer)
    
    if answer == "1"
        catch_pokemons
    elsif answer == "2"
        pokedex
    elsif answer == "3"
        statistics 
    elsif answer == "4"
        puts "Exiting ..."
    else
        puts "Incorrect option, please try again!"
    end

end





def catch_pokemons
    random_pokemon = Pokemon.all.sample
    # binding.pry
    puts "A wild #{random_pokemon.name} appeared!"
    puts "Choose one"
    puts "1. Catch"
    puts "2. Run"
    answer = gets.chomp 
    if answer == "1" 
        random_number = rand(1..2)
        if random_number == 1
            puts "You caught it! yay!"
            @@pokedex_array << random_pokemon
            
        else 
            puts "Tough luck bub! You missed!" 
        end
    end 
end  

def pokedex 
    puts "1. Lookup Pokemon"
    puts "2. View your caught Pokemon"
    answer = gets.chomp 
    if answer == "1"
        puts "Please enter a Pokemon name"
        p_name = gets.chomp 
        puts Pokemon.find_by(name: p_name)
        
    elsif answer == "2"
        puts @@pokedex_array
    else  
        puts "Your answer is whack!"
    end
end
