require 'bundler'
Bundler.require

class Player
  #variables d'instances
  attr_accessor :life_points, :name
  

  #variables de classe
 
  # initialisation
  def initialize(name)
    @name = name
    @life_points = 10
  end

  # affiche l'état du joueur
  def show_state
    @life_points > 1 ? s = 's' : s = ''
    puts "#{@name} a #{@life_points} point#{s} de vie"
  end

  # subir une attaque
  def gets_damage(hit)
    @life_points -= hit
    if @life_points <= 0
      @life_points = 0
      puts "#{@name} a été tué !"
    end
  end

  # attaquer l'autre joueur
  def attacks(other_player)
    puts "#{@name} attaque #{other_player.name}"
    hit = compute_damage
    other_player.gets_damage(hit)
    puts "il lui inflige #{hit} points de dommages"
  end

  # calcul des points d'attaque
  def compute_damage
    rand(1..6)
  end
end

