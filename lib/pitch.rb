require File.dirname(__FILE__) + '/player'
require File.dirname(__FILE__) + '/deck'

class Pitch
  attr_reader :deck, :player1, :player2, :player3, :player4, :players, :current_dealer, :card_value_lookup
  attr_accessor :current_high_bid, :trump, :current_round_player_order, :team1_card_pile, :team2_card_pile

  def initialize
    get_cards
    get_players
    @player_position = 0
    @current_round_player_order = []
    assign_current_dealer
    deal_cards
    @team1_card_pile = []
    @team2_card_pile = []
    @card_value_lookup = {"2" => 2,"3" => 3,"4" => 4,"5" => 5,"6" => 6,"7" => 7,"8" => 8,"9" => 9,"10" => 10,"J" => 11,"Q" => 12,"K" => 13, "A" => 14}
  end

  def round_ended
    assign_current_dealer
  end

  def accept_bids(bids)
    @current_high_bid  = {"bid_value" => 1}
    bids.each do |player, bid|
      unless bid.nil? or bid <= @current_high_bid["bid_value"]
        @current_high_bid = { "player" => player, "bid_value" => bid }
      end
    end
    set_round_player_order
  end

  def calculate_round_winner(played_cards)
    #set first player and card as high
    current_high_player_and_card = {"player" => played_cards.first.first, "card" => played_cards.first.last}
    #set first card value as high
    current_high_card_value = current_high_player_and_card["card"].chop
    #set first card suit as leading suite and high card suit
    leading_suit = current_high_card_suit = current_high_player_and_card["card"][-1]

    card_pile = []
    played_cards.each do |player, card|
      card_pile << card
      #all but the last character is the card value
      card_value = card.chop
      #last character is the suit
      card_suit = card[-1]
      current_high_card_value = current_high_player_and_card["card"].chop
      current_high_card_suit = current_high_player_and_card["card"][-1]

      #trump always wins against non-trump
      if card_suit == @trump and current_high_card_suit != @trump
        current_high_player_and_card = {"player" => player, "card" => card}
      #trump vs. trump comparison
      elsif card_suit == leading_suit and card_value_lookup[card_value] > card_value_lookup[current_high_card_value] and card_suit == @trump and current_high_card_suit == @trump
        current_high_player_and_card = {"player" => player, "card" => card}
      #non-trump vs. non-trump comparison
      elsif card_suit == leading_suit and card_value_lookup[card_value] > card_value_lookup[current_high_card_value] and card_suit != @trump and current_high_card_suit != @trump
        current_high_player_and_card = {"player" => player, "card" => card}
      end
    end

    if current_high_player_and_card["player"].team == "team1"
      @team1_card_pile << card_pile
    else
      @team2_card_pile << card_pile
    end
    current_high_player_and_card["player"]
  end

  def declare_trump(player, card_suit)
    if player == @current_high_bid["player"]
      @trump = card_suit
    end
  end

  def set_round_player_order
    3.times do
      break if @current_high_bid["player"] == @players.first
      @players << @players.shift
    end
    @current_round_player_order = @players
  end

  private
    def get_cards
       @deck = Deck.new
    end

    def get_players
      @player1 = Player.new "Player1", "team1"
      @player2 = Player.new "Player2", "team2"
      @player3 = Player.new "Player3", "team1"
      @player4 = Player.new "Player4", "team2"
      @players = [@player1, @player2, @player3, @player4]
    end

    def assign_current_dealer
      @current_dealer = @players[@player_position]
      @player_position += 1
    end

    def deal_cards
      #two passes dealing three cards to each four players
      @deck.shuffle_cards!
      2.times{
        self.players.each do |player|
          3.times{
            player.cards << @deck.cards.slice!(0)
          }
        end
      }
    end
end

