require "pry"

class Battle
  attr_accessor :trainer, :our_team, :opp_team, :cli, :curr_poke, :opp_poke

  def initialize(trainer, cli)
    @trainer = trainer
    @our_team = {}
    @opp_team = {}
    @cli = cli
    load_teams
    @curr_poke = @our_team.keys[0]
    @opp_poke = @opp_team.keys[0]
  end

  def load_teams
    #load our team into a hash where the keys are the pokemon and the value is the health
    @our_team[cli.pokedex_array[0]] = cli.pokedex_array[0].hp
    @our_team[cli.pokedex_array[1]] = cli.pokedex_array[1].hp
    @our_team[cli.pokedex_array[2]] = cli.pokedex_array[2].hp
    @our_team[cli.pokedex_array[3]] = cli.pokedex_array[3].hp
    @our_team[cli.pokedex_array[4]] = cli.pokedex_array[4].hp
    @our_team[cli.pokedex_array[5]] = cli.pokedex_array[5].hp


    #load the opp team into a hash where the keys are the pokeon and the value their health
    # binding.pry
    @opp_team[Pokemon.find(@trainer.p1)] = Pokemon.find(@trainer.p1).hp
    @opp_team[Pokemon.find(@trainer.p2)] = Pokemon.find(@trainer.p2).hp
    @opp_team[Pokemon.find(@trainer.p3)] = Pokemon.find(@trainer.p3).hp
    @opp_team[Pokemon.find(@trainer.p4)] = Pokemon.find(@trainer.p4).hp
    @opp_team[Pokemon.find(@trainer.p5)] = Pokemon.find(@trainer.p5).hp
    @opp_team[Pokemon.find(@trainer.p6)] = Pokemon.find(@trainer.p6).hp
  end

  def battle_welcome
    puts "!!!"
    puts @trainer.flavor_text
  end

  def main_battle_loop
    battle_welcome 
    battle_choice(battle_option)
  end

  def battle_option
    puts "1. Fight"
    puts "2. Change"
    puts "3. Forfeit"
    answer = gets.chomp
  end

  def battle_choice(battle_answer)
    if battle_answer == "1"
      battle_fight
    elsif battle_answer == "2"
      change_pokemon
    elsif battle_answer == "3"
      forefeit
    else  
      puts "Your answer is whack!"
    end
  end

  def battle_fight 
    binding.pry
    puts "Choose your move!"
    puts "1. " + Move.find(curr_poke.move1).name
    puts "2. " + Move.find(curr_poke.move2).name
    puts "3. " + Move.find(curr_poke.move3).name
    puts "4. " + Move.find(curr_poke.move4).name
    
    answer = gets.chomp 
    if answer == "1"
      @opp_team[@opp_poke] = (@opp_team[opp_poke] - Move.find(curr_poke.move1).damage.to_i)
      puts "You did #{Move.find(curr_poke.move1).damage.to_i} to #{@opp_poke.name}"
      puts "Their hp is now #{@opp_team[opp_poke]}"
    elsif answer == "2"
      @opp_team[@opp_poke] = (@opp_team[opp_poke] - Move.find(curr_poke.move2).damage.to_i)
      puts "You did #{Move.find(curr_poke.move2).damage.to_i} to #{@opp_poke.name}"
      puts "Their hp is now #{@opp_team[opp_poke]}"
    elsif answer == "3"
     @opp_team[@opp_poke] = (@opp_team[opp_poke] - Move.find(curr_poke.move3).damage.to_i) 
     puts "You did #{Move.find(curr_poke.move3).damage.to_i} to #{@opp_poke.name}"
      puts "Their hp is now #{@opp_team[opp_poke]}"
    elsif answer == "4"
      @opp_team[@opp_poke] = (@opp_team[opp_poke] - Move.find(curr_poke.move4).damage.to_i)
      puts "You did #{Move.find(curr_poke.move4).damage.to_i} to #{@opp_poke.name}"
      puts "Their hp is now #{@opp_team[opp_poke]}"
    else 
      puts "Your answer is whack yo!"
    end
  end


  def win_or_loose
    if win_condition == true
      puts "You Won!!!!"
      cli.run
    elsif loose_condition == true
      puts "You loose!!!!"
      cli.run
    end
  end

  def win_condition
    arr = @opp_team.collect do |pokemon|
      @opp_team[pokemon] <= 0
    end
    if arr.include?(false)
      return false
    else
      return true
    end
  end

  def loose_condition
    arr = @our_team.collect do |pokemon|
      @our_team[pokemon] <= 0
    end
    if arr.include?(false)
      return false
    else
      return true
    end
  end
end
