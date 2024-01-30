require 'bundler'
Bundler.require

class Game
  attr_accessor :human_player, :enemies, :max_enemies, :static_menu, :dynamic_menu, :welcome

  def initialize
    welcome
    @human_player = HumanPlayer.new(get_human_player_name)
    @max_enemies = get_max_enemies
    @enemies = self.built_ennemies_team
    @dynamic_menu = update_dynamic_menu
    @static_menu = [{option: 'a', text: 'chercher une meilleure Arme'},
    {option: 's', text: 'chercher une potion de Soin'}]
  end

  # écran d'accueil >> puts
  def welcome 
    system('clear')
    puts ''.center(47,'-')
    puts '|'+"Bienvenue sur 'ILS VEULENT TOUS MA POO' !".center(45,' ')+'|'
    puts '|'+"Sauras-tu survivre ?".center(45,' ')+'|'
    puts ''.center(47,'-')
  end

  # demander le nom du user
  def get_human_player_name
    name=''
    puts "Human Player, quel est ton nom ?"
    name = gets.chomp while name == ''
    return name
  end

  # demander le nombre d'ennemis
  def get_max_enemies
    max = 0
    puts "Combien d'ennemis veux-tu affronter?"
    max = gets.chomp.to_i while max == 0
    return max
  end

  # nombre de digits pour le nom des joueurs >> returns Integer
  def number_of_digits
    @max_enemies.to_s.length + 1
  end

  # créer les players ennemis >> return Array of Players
  def built_ennemies_team
    array = []
    (0...@max_enemies).each do |i|
      name = "Dark_%0#{number_of_digits}d" % [i]
      e = Player.new(name)
      array << e
    end
    return array
  end

  # supprimer les enemies à 0 >> returns Array
  def kill_player
    @enemies = enemies.filter{|e| e.life_points > 0}
  end

  # menu dynamique des enemies >> returns Array
  def update_dynamic_menu
    @dynamic_menu = @enemies.map do |e|
      {option: enemies.index(e).to_s, text: e.show_state}
    end
  end

  # affichage du menu >> puts
  def print_menu
    puts ''
    puts "#{human_player.name.capitalize}, quelle action veux-tu effectuer ?"
    @static_menu.each do |item|
      puts "#{item[:option]} - #{item[:text]}"
    end
    puts 'ou attaquer un joueur : '
    @dynamic_menu.each {|item| puts "#{item[:option]} - #{item[:text]}"}
  end

  # poursuite du jeu >> returns Boolean
  def is_still_ongoing?
    @human_player.life_points > 0 && @enemies.length > 0
  end

  # état des joueurs >> puts
  def show_players
    puts "\n🤍 🤍 🤍 🤍".center(25, ' ')
    puts "Voici l'état des joueurs :"
    puts @human_player.show_state
    @enemies.length.zero? ? s = '' : s = 's'
    puts "#{@enemies.length} joueur#{s} restant#{s}"
    puts @enemies.map{|e| e.avatar}.join(' ')
  end

  # enregistre le choix du user
  def get_user_choice(user_choice='')
    options = (@static_menu + @dynamic_menu).map{|e| e[:option]}
    until options.include?(user_choice) do
      user_choice = gets.chomp.downcase
    end
    return user_choice
  end

  def menu_choice(user_choice)
    if user_choice.match?(/[[:alpha:]]/)
      puts human_player.search_weapon if user_choice == 'a'
      puts human_player.search_health_pack if user_choice == 's'
    else
      puts human_player.attacks(@enemies[user_choice.to_i])
      kill_player
      update_dynamic_menu
    end
  end

  # attaque des ennemis
  def enemies_attack
    puts "💥 💥 💥 💥".center(25, ' ')
    puts "Les autres joueurs t'attaquent !"
    points = human_player.life_points
    @enemies.each do |e|
      e.attacks(human_player)
      break unless is_still_ongoing?
    end
    puts "Total infligé : #{points - human_player.life_points}"
  end

  

  # fin de partie
  def end
    if human_player.life_points.zero?
      car = '👎 '
      str = "T'as perdu ! T'es qu'un loooser"
    else
      car = '⭐️ '
      str = "BRAVO #{user.name.upcase} ! TU AS GAGNÉ !"
    end
    puts "\n#{(car*4).center(20, ' ')}\nLa partie est finie"
    puts str
  end
end
