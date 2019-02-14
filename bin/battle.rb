class Battle
  attr_accessor :trainer, :our_team, :opp_team, :cli

  def initialize(trainer, cli)
    @trainer = trainer
    @our_team = {}
    @opp_team = {}
    @cli = cli
    load_teams
  end

  def load_teams
    #load our team into a hash where the keys are the pokemon and the value is the health
    @our_team[cli.pokedex_array[0]] => cli.pokedex_array[0].hp
    @our_team[cli.pokedex_array[1]] => cli.pokedex_array[1].hp
    @our_team[cli.pokedex_array[2]] => cli.pokedex_array[2].hp
    @our_team[cli.pokedex_array[3]] => cli.pokedex_array[3].hp
    @our_team[cli.pokedex_array[4]] => cli.pokedex_array[4].hp
    @our_team[cli.pokedex_array[5]] => cli.pokedex_array[5].hp


    #load the opp team into a hash where the keys are the pokeon and the value their health
    @opp_team[@trainer.p1] = @trainer.p1.hp
    @opp_team[@trainer.p2] = @trainer.p2.hp
    @opp_team[@trainer.p3] = @trainer.p3.hp
    @opp_team[@trainer.p4] = @trainer.p4.hp
    @opp_team[@trainer.p5] = @trainer.p5.hp
    @opp_team[@trainer.p6] = @trainer.p6.hp
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
