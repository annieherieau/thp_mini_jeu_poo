require 'bundler'
Bundler.require

class Player
  #variables d'instances
  attr_accessor :life_points, :name, :avatar
  

  #variables de classe
 
  # initialisation
  def initialize(name)
    @name = name
    @life_points = 10
    @avatar = ['🐶', '🥰', '🦄​', '🐯​', '😁​', "🔥", "🧊", "🍀", '🎲'].sample
  end

  # affiche l'état du joueur
  def show_state
    @life_points > 1 ? s = 's' : s = ''
    puts "#{@avatar} #{@name} a #{@life_points} point#{s} de vie"
  end

  # subir une attaque
  def gets_damage(hit)
    @life_points -= hit
    if @life_points <= 0
      @life_points = 0
      puts "💀 #{@name} a été tué !"
    end
  end

  # attaquer l'autre joueur
  def attacks(other_player)
    puts "#{@avatar} #{@name} attaque #{other_player.name}"
    hit = compute_damage
    hit > 1 ? s='s' : s=''
    puts "et lui inflige #{hit} point#{s} de dommages"
    other_player.gets_damage(hit)
  end

  # calcul des points d'attaque
  def compute_damage
    rand(1..6)
  end
end

