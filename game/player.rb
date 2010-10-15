class Player
  attr_accessor :team, :cards, :bid
  def initialize(team)
    @team = team
    @cards = []
  end
end

