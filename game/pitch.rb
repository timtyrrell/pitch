require File.dirname(__FILE__) + '/player'
require File.dirname(__FILE__) + '/deck'

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

