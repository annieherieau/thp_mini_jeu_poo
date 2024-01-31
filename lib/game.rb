require 'bundler'
Bundler.require

class Game
  attr_accessor :human_player, :max_enemies,:players_left, :enemies_in_sight, :static_menu, :dynamic_menu

  def initialize
    welcome
    @human_player = HumanPlayer.new(get_human_player_name)
    @max_enemies = get_max_enemies
   
    @players_left = @max_enemies # représente le nombre de joueur restant dans le jeu 
    @enemies_in_sight = []  #sont ceux en vue (= qu'on peut attaquer et qui vont nosu attaquer
    new_player(4)

    @static_menu = [{option: 'a', text: 'chercher une meilleure Arme'},
    {option: 's', text: 'chercher une potion de Soin'}]
    @dynamic_menu = update_dynamic_menu(@enemies_in_sight)
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
    puts "Combien d'ennemis veux-tu affronter? (1-50)"
    max = gets.chomp.to_i until max.between?(1,50)
    # update_human_life_points(max)
    return max
  end

  # créer 1 player
  def new_player(nb)
    (1..nb).each do |i|
      name = "bot_%03d" % [(rand() * 1000).floor]
      @enemies_in_sight << Player.new(name)
      @players_left -= 1
    end
  end

  # supprimer les enemies à 0 >> returns Array
  def kill_player
    @enemies_in_sight = @enemies_in_sight.filter{|e| e.life_points > 0}
  end

  # menu dynamique des enemies >> returns Array
  def update_dynamic_menu(enemies_array)
    @dynamic_menu = enemies_array.map do |e|
      {option: enemies_array.index(e).to_s, text: e.show_state}
    end
  end

  # affichage du menu >> puts
  def print_menu
    puts ''
    puts "#{human_player.name.capitalize}, quelle action veux-tu effectuer ?"
    @static_menu.each do |item|
      puts "#{item[:option]} - #{item[:text]}"
    end
    puts "ou attaquer l'un de ces joueurs : "
    @dynamic_menu.each {|item| puts "#{item[:option].rjust(2,' ')} - #{item[:text]}"}
  end

  # poursuite du jeu >> returns Boolean
  def is_still_ongoing?
    @human_player.life_points > 0 && (@enemies_in_sight.length + @players_left) > 0
  end

  # état des joueurs >> puts
  def show_players
    puts''
    puts "🤍 🤍 🤍 🤍".center(25, ' ')
    puts "Voici l'état des joueurs :"
    puts @human_player.show_state
    @enemies_in_sight.length.zero? ? s = '' : s = 's'
    puts "#{@enemies_in_sight.length} joueur#{s} en vue et #{@players_left} restants"
    puts @enemies_in_sight.map{|e| e.avatar}.join(' ')
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
      puts human_player.attacks(@enemies_in_sight[user_choice.to_i])
      kill_player
      update_dynamic_menu(@enemies_in_sight)
    end
  end

  # attaque des ennemis
  def enemies_attack
    puts "💥 💥 💥 💥".center(25, ' ')
    puts "Les autres joueurs t'attaquent !"
    points = human_player.life_points
    @enemies_in_sight.each do |e|
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
      str = "BRAVO #{@human_player.name.upcase} ! TU AS GAGNÉ !"
    end
    puts "\n#{(car*4).center(20, ' ')}\nLa partie est finie"
    puts str
  end

  # rajouter des ennemis en vue
  def new_players_in_sight
    if @players_left <= @enemies_in_sight.length
      puts 'Tous les joueurs sont déjà en vue'
    end
    if dice_roll ==1
      puts "Pas d'ennemis en vue"
    end
    if dice_roll.between?(2,4)
      new_player(1)
      puts "1 ennemi en plus"
    end
    if dice_roll >= 5
      new_player(2)
      puts "Zut, 2 ennemis en plus"
    end
    
  end

  # lancer de dés
  def dice_roll
    rand(1..6)
  end
end