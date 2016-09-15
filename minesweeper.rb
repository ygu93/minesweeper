require_relative 'board'
require_relative 'player'

class Minesweeper

  def initialize(board = Board.generate_grid, player = Player.generate)
    @board = board
    @player = player
  end

  def run
    running = true
    while running
      @board.render
      puts "Choose a square: (ex. 5, 4)"
      coordinates = @player.get_coordinates
      puts "Would you like to flag or reveal?: (r/f)"
      choice = @player.get_choice
    end
  end

end
