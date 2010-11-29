module Pitch
  class Game
    attr_reader :deck, :player1, :player2, :player3, :player4, :players, :current_dealer, :card_value_lookup
    attr_accessor :current_high_bid, :trump, :current_round_player_order, :team1_card_pile, :team2_card_pile

    def initialize
      @player_position = 0
      @current_round_player_order = []
      @team1_card_pile = []
      @team2_card_pile = []
      @card_value_lookup = {"2" => 2,"3" => 3,"4" => 4,"5" => 5,"6" => 6,"7" => 7,"8" => 8,"9" => 9,"10" => 10,"J" => 11,"Q" => 12,"K" => 13, "A" => 14}
    end

    def run
      start_round

      bids = Pitch::Util::ScreenUtil.input_bids(@players)
      accept_bids(bids)
      bid_winner = Pitch::Util::ScreenUtil.declare_bid_winner(self)
      trump_selection = Pitch::Util::ScreenUtil.bid_winner_declares_trump(bid_winner)
      declare_trump(bid_winner, @deck.card_suit[trump_selection - 1])
      played_cards = Pitch::Util::ScreenUtil.collect_cards(self, bid_winner)

      #calculate and output current turn results
      winning_player = Pitch::ScoreCalculator.calculate_round_winner(self, played_cards)
      puts "#{winning_player.name} on #{winning_player.team} won the hand!"
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

    def start_round
      get_cards
      get_players
      assign_current_dealer
      deal_cards
    end

    private
      def get_cards
         @deck = Pitch::Deck.new
      end

      def get_players
        @player1 = Pitch::Player.new "Player1", "team1"
        @player2 = Pitch::Player.new "Player2", "team2"
        @player3 = Pitch::Player.new "Player3", "team1"
        @player4 = Pitch::Player.new "Player4", "team2"
        @players = [@player1, @player2, @player3, @player4]
      end

      def assign_current_dealer
        @current_dealer = @players[@player_position]
        @player_position += 1
      end

      def deal_cards
        #two passes dealing three cards to each of the four players
        @deck.shuffle_cards!
        2.times{
          @players.each do |player|
            3.times{
              player.cards << @deck.cards.slice!(0)
            }
          end
        }
      end
  end
end

