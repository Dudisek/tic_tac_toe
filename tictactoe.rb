require_relative 'lib/tictactoe.rb'

game = Game.new
game.determine_game_mode
game.determine_starter

game.start