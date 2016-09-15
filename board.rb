require "colorize"
require_relative "tile"

class Board
  attr_reader :grid

  def self.generate_grid
    grid = Array.new(9) { Array.new(9) { Tile.new } }
    index_numbers = (0..8).to_a
    all_coordinates = index_numbers.product(index_numbers)
    bomb_coordinates = all_coordinates.sample(10)
    bomb_coordinates.each do |pos|
      grid[pos.first][pos.last].set_bomb
      # Hash where we update neighbor fringe values
    end
    self.new(grid)
  end

  def initialize(grid)
    @grid = grid
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def render
    puts "  " + (0..8).to_a.join(" ")
    @grid.each_with_index do |row, i|
      print "#{i} "
      row.each do |tile|
        if tile.is_bomb? && tile.is_revealed?
          print "* ".red
        elsif tile.is_revealed?
          print "#{tile.value}"
        else
          print "□ "
        end
      end
      print "\n"
    end
  end
end
