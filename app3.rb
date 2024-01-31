require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

# Start game 
# new game
my_game = Game.new
my_game.human_player

# play rounds
# bouble jusqu'à User > 0 ou nbre d'enemies > 0
while my_game.is_still_ongoing? do 

  # états des joueurs
  my_game.show_players
  gets.chomp
  # affichage du menu
  my_game.print_menu

  # enregistrer choix du user + exécuter l'action
  my_game.menu_choice(my_game.get_user_choice)
  gets.chomp
  system('clear')
  # sortir de la boucle si tous les enemeis sont à 0
  break unless my_game.is_still_ongoing?
 

  # attaque des enemies
  my_game.enemies_attack
  my_game.new_players_in_sight
end

# End game
my_game.end