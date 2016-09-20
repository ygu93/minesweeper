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
          print "F ".red
        elsif tile.is_revealed? && tile.value == 1
          print "#{tile.value} ".blue
        elsif tile.is_revealed? && tile.value > 1
          print "#{tile.value} ".green
        elsif tile.is_revealed? && tile.value == 0
          print "□ "
        else
          print "■ "
        end
      end
      print "\n"
    end
  end


  def won?
    @grid.each do |row|
      row.each do |tile|
        return false if tile.is_revealed? == false && tile.is_bomb? == false
      end
    end
    true
  end

  def lost?
    @grid.each do |row|
      row.each do |tile|
        return true if tile.is_revealed? == true && tile.is_bomb?
      end
    end
    false
  end

  def chain_reveal(pos)
    self[pos].reveal
    valid_neighbors = neighbors(pos).reject { |pos| self[pos].is_revealed? }
    return if valid_neighbors.any? { |pos| self[pos].is_bomb? }
    valid_neighbors.each do |pos|
      chain_reveal(pos)
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
      neighbors(pos).each { |pos| self[pos].increase_value }
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
    result
  end
end
