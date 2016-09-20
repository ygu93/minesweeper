require_relative 'board'
require_relative 'player'

class Minesweeper

  def initialize(board = Board.new, player = Player.generate)
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
      make_move(coordinates, choice)
      if @board.won?
        running = false
        @board.render
        puts "Congratulations, you won!"
        sleep(5)
      elsif @board.lost?
        running = false
        @board.render
        puts "You lose!"
        sleep(5)
      end
      system("clear")
    end
  end

  private

  def make_move(pos, action)
    if action == "r"
      @board.chain_reveal(pos)
    elsif action == "f"
      @board[pos].toggle_flag
    end
  end



end

game = Minesweeper.new
game.run
