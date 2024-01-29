require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

# Start game : players
player1 = Player.new("Josiane")
player2 = Player.new("José")

puts "À ma droite #{player1.name} #{player1.avatar}"
puts "À ma gauche #{player2.name} #{player2.avatar}"
puts "------"

# Fighting rounds 
loop do
  break if player1.life_points.zero? || player1.life_points.zero?
  
  puts "🤍 🤍 🤍 🤍".center(25, ' ')
  puts "Voici l'état de chaque joueur :"
  player1.show_state
  player2.show_state
  
  puts "💥 💥 💥 💥".center(25, ' ')
  puts "Passons à la phase d'attaque :"
  player1.attacks(player2)
  player2.attacks(player1)
  puts ''
end

# End game = winner
player1.life_points.zero? ? winner = player2 : player1
puts "⭐️ ⭐️ ⭐️ ⭐️".center(25, ' ')
puts "VAINQUEUR : #{winner.name} #{winner.avatar}"