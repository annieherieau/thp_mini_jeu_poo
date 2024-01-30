require 'bundler'
Bundler.require

class Game
  attr_accessor :human_player, :enemies, :max_enemies, :static_menu, :dynamic_menu

  def initialize(name, max_enemies=4)
    @human_player = HumanPlayer.new(name)
    @max_enemies = max_enemies
    @enemies = self.built_ennemies_team
    @dynamic_menu = update_dynamic_menu
    @static_menu = [{option: 'a', text: 'chercher une meilleure Arme'},
    {option: 's', text: 'chercher une potion de Soin'}]
  end

  # nombre de digits pour le nom des joueurs >> returns Integer
  def number_of_digits
    @max_enemies.to_s.length + 1
  end

  # créer les players ennemis >> return Array of Players
  def built_ennemies_team
    array = []
    (1..@max_enemies).each do |i|
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
    @human_player.life_points > 0 || @enemies.length > 0
  end

  # état des joueurs >> puts
  def show_players
    puts ''
    puts "🤍 🤍 🤍 🤍".center(25, ' ')
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
    end
  end

  # attaque des ennemis
  def enemies_attack
    puts "💥 💥 💥 💥".center(25, ' ')
    puts "Les autres joueurs t'attaquent !"
    points = human_player.life_points
    @enemies.each {|e| puts e.attacks(human_player)}
    puts "Total infligé : #{points - human_player.life_points}"
  end

  def end

  end
end
