require File.dirname(__FILE__) + '/player'
require File.dirname(__FILE__) + '/deck'

class Pitch
  attr_reader :deck, :player1, :player2, :player3, :player4, :players, :current_dealer
  attr_accessor :current_high_bid, :trump

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

  def accept_bids(bids)
   @current_high_bid  = {"bid_value" => 1}
    bids.each do |key, value|
      unless value.nil? or value <= @current_high_bid["bid_value"]
        @current_high_bid = { "player" => key, "bid_value" => value }
      end
    end
  end

  private
    def deal_cards
       2.times{
          self.players.each do |player|
            3.times{
                player.cards << @deck.cards.slice!(0)
              }
          end
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
      @player1 = Player.new "team1", "Player1"
      @player2 = Player.new "team2", "Player2"
      @player3 = Player.new "team1", "Player3"
      @player4 = Player.new "team2", "Player4"
      @players = [@player1, @player2, @player3, @player4]
    end
end

