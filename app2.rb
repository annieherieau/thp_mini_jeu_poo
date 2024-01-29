require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

# Start game : players
player1 = Player.new("Josiane")
player2 = Player.new("José")
annie = HumanPlayer.new('Annie')
binding.pry