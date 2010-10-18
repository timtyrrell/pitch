class Player
  attr_accessor :team, :cards, :name
  def initialize(team, name)
    @team = team
    @name = name
    @cards = []
  end
end

