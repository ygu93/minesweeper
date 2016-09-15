class Player
  def self.generate
    puts "Please input your name"
    name = gets.chomp
    self.new(name)
  end

  def initialize(name)
    @name = name
  end

  def get_coordinates
    position = gets.chomp
  end

  def get_choice
    choice = gets.chomp
  end
end
