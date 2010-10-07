#require 'pitch'

class Pitch
  attr_reader :deck, :player1, :player2, :player3, :player4, :players
  attr_accessor :current_dealer

  def initialize
    get_cards
    get_players
    @current_dealer = @players.first
  end

#  def round_ended
#    @current_dealer =
#  end

  private
    def get_cards
       @deck = Deck.new
    end

    def get_players
      @player1 = Player.new
      @player2 = Player.new
      @player3 = Player.new
      @player4 = Player.new
      @players = [@player1, @player2, @player3, @player4]
    end
end

class Player

end

class Deck
  attr_reader :cards
  def initialize
     @cards = [
      "2H","3H","4H","5H","6H","7H","8H","9H","10H", "JH", "QH", "KH", "AH",
      "2D","3D","4D","5D","6D","7D","8D","9D","10D", "JD", "QD", "KD", "AD",
      "2S","3S","4S","5S","6S","7S","8S","9S","10S", "JS", "QS", "KS", "AS",
      "2C","3C","4C","5C","6C","7C","8C","9C","10C", "JC", "QC", "KC", "AC"
      ]
  end

  def shuffle_cards
    self.cards.shuffle!
  end
end

describe Pitch do
  before(:each) do
    @pitch = Pitch.new
  end
  describe "when starting a game of pitch" do
    it "should have 52 cards" do
      @pitch.deck.cards.length.should == 52
    end

    it "should shuffle the cards into a random order" do
      @current_deck = @pitch.deck.cards.clone
      @match_result = @current_deck <=> @pitch.deck.shuffle_cards
      @match_result.should_not == 0
    end

    it "should have four players" do
      @pitch.players.length.should == 4
    end

    it "should know which player has the current dealer do" do
      @pitch.current_dealer == @pitch.player1
    end

#    it "should assign the next player as the current dealer when the round ends" do
#      @pitch.round_ended
#      @pitch.current_dealer.should ==
#    end

  end
end

