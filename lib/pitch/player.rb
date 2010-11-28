module Pitch
  class Player
    attr_accessor :name, :team, :cards, :bid
    def initialize(name, team)
      @name = name
      @team = team
      @cards = []
    end
  end
end

