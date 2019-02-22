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
    cli.pokedex_array.each do |pokemon|
      @our_team[pokemon] = pokemon.hp
    end

    #load the opp team into a hash where the keys are the pokeon and the value their health
    @trainer.pokemons.each do |pokemon|
      @opp_team[pokemon] = pokemon.hp
    end
  end

  def battle_welcome
    puts ""
    puts "!!!"
    puts ""
    puts @trainer.flavor_text
    puts ""
  end

  #This method runs our battle
  def main_battle_loop
    battle_welcome
    choice = 1
    while choice != 3
      choice = battle_option
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
    puts ""
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
    puts ""
    puts "Choose your move!"
    @curr_poke.moves.each_with_index do |m, index|
      puts "#{index + 1}. #{m.name}"
    end
    puts ""
    answer = gets.chomp

    if !["1","2","3","4"].include?(answer)
      puts "Your answer is whack yo!"
      return
    end

    move = @curr_poke.moves[answer.to_i - 1]
    puts ""
    @opp_team[@opp_poke] = (@opp_team[opp_poke] - move.damage.to_i)
    puts "You did #{move.damage.to_i} damage to #{@opp_poke.name.capitalize}"
    puts ""
    puts "Their hp is now #{@opp_team[opp_poke]}"
  end

  def opp_attack
    m_name = @opp_poke.moves.sample
    dmg = m_name.damage.to_i
    @our_team[@curr_poke] = (@our_team[@curr_poke] - dmg)
    if @our_team[@curr_poke] < 0
      @our_team[@curr_poke] = 0
    end
    puts "#{@trainer.name} used #{m_name.name}"
    puts "#{@opp_poke.name} did #{dmg} damage to #{@curr_poke.name.capitalize}"
    puts ""
  end

  def opp_poke_hp_check
    if @opp_team[@opp_poke] <= 0
      puts "#{@opp_poke.name.capitalize} has fainted"
      puts ""
      return true
    else
      return false
    end
  end

  def curr_poke_hp_check
    if @our_team[@curr_poke] <= 0
      puts "#{@curr_poke.name.capitalize} has fainted"
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
    puts "#{@trainer.name} sent out #{@opp_poke.name.capitalize}"
  end

  def curr_change_poke
    puts "Please pick a pokemon to send out"
    puts "---------------------------------"
    @our_team.each do |k,v|
      puts "#{k.name} -> HP: #{v}"
    end
    puts ""
    puts "Please type in their name"
    puts ""
    answer = gets.chomp

    result = @our_team.find do |k, v|
      k.name.downcase == answer.downcase && v > 0
    end

    if result.nil?
      puts ""
      puts "Please type a valid name"
      curr_change_poke
    else
      @curr_poke = result.first
    end
  end

  def win_or_loose
    if win_condition == true
      puts "You Won!!!!"
      cli.run
    elsif loose_condition == true
      puts "You lose!!!!"
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
