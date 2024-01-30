require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

# Start game : players
player1 = Player.new("Josiane")
player2 = Player.new("José")
# modifier avatar player 2 si les 2 avatars sont identiques
player2.avatar = '🎃' if player1.avatar == player2.avatar

puts "À ma droite #{player1.name} #{player1.avatar}"
puts "À ma gauche #{player2.name} #{player2.avatar}"
puts "------"

# Play rounds 
# bouble jusqu'a ce que l'un des players ait 0 pt
until player1.life_points.zero? || player2.life_points.zero?
  # show_state
  puts "🤍 🤍 🤍 🤍".center(25, ' ')
  puts "Voici l'état de chaque joueur :"
  puts player1.show_state
  puts player2.show_state
  
  # attacks
  puts "💥 💥 💥 💥".center(25, ' ')
  puts "Passons à la phase d'attaque :"
  player1.attacks(player2)
  player2.attacks(player1) unless player2.life_points.zero?
  puts ''
end

# End game = winner
player1.life_points.zero? ? winner = player2 : winner = player1
puts "⭐️ ⭐️ ⭐️ ⭐️".center(25, ' ')
puts "VAINQUEUR : #{winner.name} #{winner.avatar}"