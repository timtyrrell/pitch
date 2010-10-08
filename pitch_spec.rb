#require 'pitch' ????


class Pitch
  attr_reader :deck, :player1, :player2, :player3, :player4, :players, :current_dealer

  def initialize
    get_cards
    get_players
    @player_position = 0
    assign_current_dealer
    deal_cards
  end

  def round_ended
    assign_current_dealer
  end

  def accept_bids
    #TODO: display all bids by players
    puts "State your bid (2 to 5):"
    STDOUT.flush
    bid = gets.chomp
    puts "received bid of " + bid
  end

  private


    def deal_cards
       2.times{
          self.players.each { |player|
            3.times{
                player.cards << @deck.cards.slice!(0)
              }
            }
       }
    end

    def get_cards
       @deck = Deck.new
    end

    def assign_current_dealer
      @current_dealer = @players[@player_position]
      @player_position += 1
    end

    def get_players
      @player1 = Player.new :team1
      @player2 = Player.new :team2
      @player3 = Player.new :team1
      @player4 = Player.new :team2
      @players = [@player1, @player2, @player3, @player4]
    end
end

class Player
  attr_accessor :team, :cards
  def initialize(team)
    @team = team
    @cards = []
  end
end

class Deck
  attr_accessor :cards
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
    it "should shuffle the cards into a random order" do
      @current_deck = @pitch.deck.cards.clone
      @match_result = @current_deck <=> @pitch.deck.shuffle_cards
      @match_result.should_not == 0
    end

    it "should have four players" do
      @pitch.players.length.should == 4
    end

    it "should know which player has the current dealer do" do
      @pitch.current_dealer.should == @pitch.player1
    end

     it "should assign the second player as the current dealer" do
      @pitch.round_ended
      @pitch.current_dealer.should  == @pitch.player2
    end

     it "should assign the third player as the current dealer" do
      @pitch.round_ended
      @pitch.round_ended
      @pitch.current_dealer.should == @pitch.player3
    end

     it "should assign the fourth player as the current dealer" do
      @pitch.round_ended
      @pitch.round_ended
      @pitch.round_ended
      @pitch.current_dealer.should == @pitch.player4
    end

    it "players should have 6 cards" do
      @pitch.player1.cards.length.should == 6
    end

  end
end

