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
user = HumanPlayer.new

# Computer enemies
enemies = []
enemies_names = ['Josiane', 'José']
max_enemies = 2
(0...max_enemies).each do |i|
  enemies << Player.new(enemies_names[i])
end

# play rounds
static_menu= [ 
  {option: 'a', text: 'chercher une meilleure Arme'},
  {option: 's', text: 'chercher une potion de Soin'}
]

# bouble jusqu'à User à 0 ou somme de points enemies à 0
until user.life_points.zero? || enemies.map{|e| e.life_points}.sum.zero? do 

  # show_state
  puts ''
  puts "🤍 🤍 🤍 🤍".center(25, ' ')
  # puts "Voici l'état de chaque joueur :"
  puts user.show_state
  
  # choix action du HumanPlayer
  # affichage du menu
  puts ''
  puts "#{user.name.capitalize}, quelle action veux-tu effectuer ?"
  static_menu.each {|item| puts "#{item[:option]} - #{item[:text]}"}

  # création du menu des enemies: sauf ceux à 0 pts
  dynamic_menu = enemies.map {|plr|
    {option: enemies.index(plr).to_s, text: plr.show_state} unless plr.life_points.zero?}

  puts 'ou attaquer un joueur : '
  dynamic_menu.each {|item| puts "#{item[:option]} - #{item[:text]}"}

  # enregistrer choix du user
  options = (static_menu + dynamic_menu).map{|e| e[:option]}
  user_choice = ''
  until options.include?(user_choice) do
    user_choice = gets.chomp.downcase
  end

  # executer action du user
  if user_choice.match?(/[[:alpha:]]/)
    puts user.search_weapon if user_choice == 'a'
    puts user.search_health_pack if user_choice == 's'
  else
    puts user.attacks(enemies[user_choice.to_i])
  end
  
  gets.chomp

  # attaque des enemies
  puts "💥 💥 💥 💥".center(25, ' ')
  puts "Les autres joueurs t'attaquent !"
  user_points = user.life_points
  enemies.each {|e| e.attacks(user) unless e.life_points.zero?}
  puts "Total infligé : #{user_points - user.life_points}"

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