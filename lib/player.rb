require 'bundler'
Bundler.require

class Player
  # variables d'instances
  attr_accessor :life_points, :name, :avatar, :max_life_points
  # gestion d'un max de vie
  

  # initialisation
  def initialize(name)
    @name = name
    @max_life_points = 10
    @life_points = @max_life_points
    @avatar = ['🐶', '🦄​', '🐯​', '🔥', '🍀', '🎲', '😸'].sample
  end

  # string de l'état du joueur >> return String
  def show_state
    s = @life_points > 1 ? 's' : ''
    "#{@avatar} #{@name} a #{@life_points} point#{s} de vie"
  end

  # subir une attaque  >> return String
  def gets_damage(hit)
    @life_points -= hit
    str = ''
    check_life_points
    if @life_points.zero?
      @avatar = '💀 '
      str = "#{@avatar} #{@name} a été tué !"
    end
    str
  end

  # attaquer l'autre joueur  >> return String
  def attacks(other_player)
    hit = compute_damage
    s = hit > 1 ? 's' : ''
    str = "#{@avatar} #{@name} attaque #{other_player.name}
    et lui inflige #{hit} point#{s} de dommages\n"
    str += other_player.gets_damage(hit)
    str
  end

  # calcul des points d'attaque  >> return Integer
  def compute_damage
    rand(1..6)
  end

  # check si les life_points sont entre le mini et le maxi  >> return Integer
  def check_life_points
    @life_points = 0 if @life_points < 0
    @life_points = @max_life_points if @life_points > max_life_points
    return @life_points
  end
end

class HumanPlayer < Player
  attr_accessor :weapon_level

  # initialisation
  def initialize(name)
    @name = name
    @max_life_points = 100
    @life_points = @max_life_points
    @avatar = ['🥰', '😁​', '😇', '😎', '🥳'].sample
    @weapon_level = 1
  end

  # affiche l'état du joueur
  def show_state
    s = @life_points > 1 ? 's' : ''
    "#{@avatar} #{@name} a #{@life_points} point#{s} de vie et une arme de niveau #{@weapon_level}"
  end

  # calcul des points d'attaque
  def compute_damage
    rand(1..6) * weapon_level
  end

  # chercher une nouvelle arme
  def search_weapon
    new_weapon = rand(1..6)
    str = "Tu as trouvé une arme de niveau #{new_weapon}\n"
    if new_weapon > @weapon_level
      @weapon_level = new_weapon
      str += 'Youhou ! elle est meilleure que ton arme actuelle : tu la prends.'
    else
      str += "M@*#$... elle n'est pas mieux que ton arme actuelle..."
    end
    str
  end

  # chercher un pack de points de vie
  def search_health_pack
    case rand(1..6)
    when 1
      return "Tu n'as rien trouvé... "
    when 6
      @life_points += 80
      check_life_points
      return "Waow, tu as trouvé un pack de +80 points de vie !"
    else
      @life_points += 50
      check_life_points
      return 'Bravo, tu as trouvé un pack de +50 points de vie !'
    end
  end

end
