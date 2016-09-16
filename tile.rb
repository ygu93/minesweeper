class Tile

  def initialize(value = 0, flagged = false, bomb = false, revealed = false)
    @value, @flagged = value, flagged
    @bomb = bomb
    @revealed = revealed
  end

  def value
    @value
  end

  def set_bomb
    @bomb = true
  end

  def is_bomb?
    @bomb
  end

  def is_revealed?
    @revealed
  end

  def reveal
    @revealed = true unless @flagged
  end

  def toggle_flag
    @flagged = !@flagged
  end

  def increase_value
    @value += 1
  end
end
