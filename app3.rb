require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

# Start game 
puts ''.center(47,'-')
puts '|'+"Bienvenue sur 'ILS VEULENT TOUS MA POO' !".center(45,' ')+'|'
puts '|'+"Sauras-tu survivre ?".center(45,' ')+'|'
puts ''.center(47,'-')
puts ''

# New Human Player
# demander le nom au joueur
puts 'Human Player, quel est ton nom ?'
name = ''
name = gets.chomp while name == ''

# new game
my_game = Game.new(name)
user = my_game.human_player
enemies = my_game.enemies

# play rounds

# bouble jusqu'à User > 0 ou nbre d'enemies > 0
while my_game.is_still_ongoing? do 

  # états des joueurs
  my_game.show_players
  
  # affichage du menu
  my_game.print_menu

  # enregistrer choix du user + exécuter l'action
  my_game.menu_choice(my_game.get_user_choice)

  # sortir de la boucle si tous les enemeis sont à 0
  break unless my_game.is_still_ongoing?
  gets.chomp

  # attaque des enemies
  my_game.enemies_attack

end

# End game
if user.life_points.zero?
  car = '👎 '
  str = 'Loser ! Tu as perdu !'
else
  car = '⭐️ '
  str = "BRAVO #{user.name.upcase} ! TU AS GAGNÉ !"
end

puts ''
puts (car*4).center(20, ' ')
puts 'La partie est finie'
puts str

binding.pry