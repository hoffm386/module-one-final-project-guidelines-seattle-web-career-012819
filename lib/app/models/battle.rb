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
    choice = battle_option
    while choice != 3
      battle_choice(choice)
      if opp_poke_hp_check == true
        win_or_loose
        opp_change_poke
      end
      opp_attack
      if curr_poke_hp_check == true
        win_or_loose
        curr_change_poke
      end
      win_or_loose
    end
  end

  def forfeit
    puts "You blacked out and they took your money, you're like 10"
    exit
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
      curr_change_poke
    elsif battle_answer == "3"
      forfeit
    else
      puts "Your answer is whack!"
    end
  end

  def battle_fight
    puts "Choose your move!"
    puts "1. #{Move.find(@curr_poke.move1).name}"
    puts "2. #{Move.find(@curr_poke.move2).name}"
    puts "3. #{Move.find(@curr_poke.move3).name}"
    puts "4. #{Move.find(@curr_poke.move4).name}"

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

  def opp_attack
    arr = []
    arr << Move.find(opp_poke.move1)
    arr << Move.find(opp_poke.move2)
    arr << Move.find(opp_poke.move3)
    arr << Move.find(opp_poke.move4)
    arr.sample
    m_name = Move.find(arr.sample.id)
    dmg = m_name.damage.to_i
    @our_team[@curr_poke] = (@our_team[@curr_poke] - dmg)
    puts "#{@trainer.name} used #{m_name.name}"
    puts "#{@opp_poke.name} did #{dmg} to #{@curr_poke.name}"
  end

  def opp_poke_hp_check
    if @opp_team[@opp_poke] <= 0
      puts "#{@opp_poke.name} has fainted"
      return true
    else
      return false
    end
  end

  def curr_poke_hp_check
    if @our_team[@curr_poke] <= 0
      puts "#{@curr_poke.name} has fainted"
      return true
    else
      return false
    end
  end

#show off code
  def opp_change_poke
    arr = @opp_team.select do |p|
      @opp_team[p] > 0
    end
    @opp_poke = arr.keys.sample
    puts "#{@trainer.name} sent out #{@opp_poke.name}"
  end

  def curr_change_poke
    puts "Please pick a pokemon to send out"
    @our_team.each do |k,v|
      puts "#{k.name} -> HP: #{v}"
    end
    puts "please type in their name"
    answer = gets.chomp

    arr = @our_team.keys.collect do |x|
      x.name.downcase
    end

    if arr.include?(answer.downcase) == false
      puts "Please type a valid name"
      curr_change_poke
    else
      if @our_team[Pokemon.find_by(name: answer.downcase)] > 0
        @curr_poke = Pokemon.find_by(name: answer.downcase)
      else
        puts "This pokemon dead"
        curr_change_poke
      end
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
      pokemon[1] <= 0
    end
    if arr.include?(false)
      return false
    else
      return true
    end
  end

  def loose_condition
    arr = @our_team.collect do |pokemon|
      pokemon[1] <= 0
    end
    if arr.include?(false)
      return false
    else
      return true
    end
  end
end
