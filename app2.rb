require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

# Start game 
puts '-----------------------------------------------------'
puts "|     Bienvenue sur 'ILS VEULENT TOUS MA POO' !     |"
puts "|  Le but du jeu est d'être le dernier survivant !  |"
puts '-----------------------------------------------------'
puts ''

# New Human Player
user = HumanPlayer.new

# Computer players
players = []
player_names = ['Josiane', 'José']
max_players = 2
(0...max_players).each do |i|
  players << Player.new(player_names[i])
end

# play rounds
static_menu= [ 
  {option: 'a', text: 'chercher une meilleure Arme'},
  {option: 's', text: 'chercher une meilleure Arme'}
]

# bouble jusqu'à User à 0 ou somme de points players à 0
until user.life_points.zero? || players.map{|p| p.life_points}.sum.zero? do 

  # show_state
  puts "🤍 🤍 🤍 🤍".center(25, ' ')
  puts "Voici l'état de chaque joueur :"
  user.show_state
  puts ''

  
  # choix action du HumanPlayer
  # affichage du menu
  puts "#{user.name.capitalize}, quelle action veux-tu effectuer ?"
  static_menu.each {|item| puts "#{item[:option]} - #{item[:text]}"}

  # création du menu des players: sauf ceux à 0 pts
  dynamic_menu = players.map {|plr| {option: players.index(plr).to_s, text: plr.show_state} unless plr.life_points.zero?}

  puts 'ou attaquer un joueur : '
  dynamic_menu.each {|item| puts "#{item[:option]} - #{item[:text]}"}

  # choix du user
  options = (static_menu + dynamic_menu).map{|p| p[:option]}
  user_choice = ''
  until options.include?(user_choice) do
    user_choice = gets.chomp
  end

  if user_choice.match?(/[[:alpha:]]/)
    user.search_weapon if user_choice == 'a'
    
  else

  end
  # attacks
  puts "💥 💥 💥 💥".center(25, ' ')
  puts "Passons à la phase d'attaque :"
  players.first.gets_damage(5)
  players.last.gets_damage(5)
  # player1.attacks(player2)
  # player2.attacks(player1)
  puts ''
end

# End game
if user.life_points.zero?
  car = '👎 '
  str = 'Loser ! Tu as perdu !'
else
  car = '⭐️ '
  str = "BRAVO #{user.name.upcase} ! TU AS GAGNÉ !"
end

puts (car*4).center(20, ' ')
puts 'La partie est finie'
puts str

binding.pry