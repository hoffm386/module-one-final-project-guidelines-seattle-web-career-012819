require "pry"

class CLI
@@pokedex_array = []

    def pokedex_array
      @@pokedex_array
    end

    def run
    #get_pokemon_from_api()
    seed_trainers
    welcome
    choice = options
        while choice != 4
            option_answer(choice)
            choice = options
        end
    end

    def welcome
        puts "Welcome to Alpha Super Ultra Purple!"
    end

    def options
        puts ""
        puts "Choose an option"
        puts "1. Catch a Pokemon"
        puts "2. Pokedex"
        puts "3. Battle a Trainer!"
        puts "4. Exit"
        answer = gets.chomp
    end


    def option_answer(answer)
        if answer == "1"
            catch_pokemons
        elsif answer == "2"
            pokedex
        elsif answer == "3"
            battle
        elsif answer == "4"
            puts "Exiting ..."
            exit
        else
            puts "Incorrect option, please try again!"
        end
    end





    def catch_pokemons
        random_pokemon = Pokemon.all.sample
        # binding.pry
        puts ""
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
    puts ""
        puts "1. Lookup Pokemon"
        puts "2. View your caught Pokemon"
        answer = gets.chomp
        if answer == "1"
            puts "Please enter a Pokemon name"
            p_name = gets.chomp

            puts ""
            puts Pokemon.find_by(name: p_name).print
            puts ""
        elsif answer == "2"
            @@pokedex_array.each do |poke|
            puts ""
            puts poke.print
            puts ""
            end
        else
            puts "Your answer is whack!"
        end
    end

    def battle
      @@pokedex_array = [Pokemon.all.sample, Pokemon.all.sample, Pokemon.all.sample, Pokemon.all.sample, Pokemon.all.sample, Pokemon.all.sample]
      b = Battle.new(Trainer.all.sample, self)
      b.main_battle_loop
    end

end
