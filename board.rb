require "colorize"
require_relative "tile"

class Board
  attr_reader :grid

  def initialize(grid = nil)
    @grid = grid.nil? ? generate_grid : grid
    generate_fringe_values
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
        if tile.is_revealed? && tile.is_bomb?
          print "* ".red
        elsif tile.is_flagged?
          print "F ".yellow
        elsif tile.is_revealed?
          print "#{tile.value} "
        else
          print "□ "
        end
      end
      print "\n"
    end
  end

  private

  def generate_grid
    grid = Array.new(9) { Array.new(9) { Tile.new } }
    index_numbers = (0..8).to_a
    all_coordinates = index_numbers.product(index_numbers)
    @bomb_coordinates = all_coordinates.sample(10)
    @bomb_coordinates.each do |pos|
      grid[pos.first][pos.last].set_bomb
    end
    grid
  end

  def generate_fringe_values
    @bomb_coordinates.each do |pos|
      neighbors(pos).each { |neighbor| neighbor.increase_value }
    end
  end

  def neighbors(pos)
    pos
    x_range = ((pos.first - 1)..(pos.first + 1)).to_a
    y_range = ((pos.last - 1)..(pos.last + 1)).to_a
    result = x_range.product(y_range)
    result.delete(pos)
    result.reject! do |pos|
      range = (0..8).to_a
      !(range.include?(pos.first) && range.include?(pos.last))
    end
    result.map { |pos| self[pos] }
  end
end
