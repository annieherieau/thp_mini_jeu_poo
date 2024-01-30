require 'bundler'
Bundler.require

class Player
  #variables d'instances
  attr_accessor :life_points, :name, :avatar
  
  # initialisation
  def initialize(name)
    @name = name
    @life_points = 10
    @avatar = ['🐶', '🦄​', '🐯​', "🔥", "🍀", '🎲', '😸'].sample
  end

  # string de l'état du joueur
  def show_state
    @life_points > 1 ? s = 's' : s = ''
    return "#{@avatar} #{@name} a #{@life_points} point#{s} de vie"
  end

  # subir une attaque
  def gets_damage(hit)
    @life_points -= hit
    if @life_points <= 0
      @life_points = 0
      @avatar = '💀 '
      puts "#{@avatar} #{@name} a été tué ! #{@life_points}"
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

class HumanPlayer < Player
  attr_accessor :weapon_level

  # initialisation
  def initialize
    @name = get_user_name
    @life_points = 100
    @avatar = ['🥰', '😁​', '😇', '😎', '🥳'].sample
    @weapon_level = 1
  end

  # demander le nom au joueur
  def get_user_name
    puts 'Human Player, quel est ton nom ?'
    name = ''
    while name == ''
      name = gets.chomp
    end
    return name
  end
  # affiche l'état du joueur
  def show_state
    @life_points > 1 ? s = 's' : s = ''
    puts "#{@avatar} #{@name} a #{@life_points} point#{s} de vie et une arme de niveau #{@weapon_level}"
  end

  # calcul des points d'attaque
  def compute_damage
    rand(1..6)*weapon_level
  end

  # chercher une nouvelle arme
  def search_weapon
    new_weapon = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{new_weapon}"
    if new_weapon > @weapon_level
      @weapon_level = new_weapon 
      puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
    else
    "M@*#$... elle n'est pas mieux que ton arme actuelle..."
    end
  end

  # chercher un pack de points de vie
  def search_health_pack
    pack = rand(1..6)
    case pack
    when 1
      puts "Tu n'as rien trouvé... "
    when 6
      @life_points += 80
      puts "Waow, tu as trouvé un pack de +80 points de vie !"
    else
      @life_points += 50
      puts "Bravo, tu as trouvé un pack de +50 points de vie !"
    end
    @life_points= 100 if @life_points > 100
  end

end
