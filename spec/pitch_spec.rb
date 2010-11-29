$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
require 'pitch'

describe "Pitch game testing" do
  before(:each) do
    @pitch = Pitch::Game.new
    @pitch.start_round
  end
  describe "when starting a game of pitch" do
    it "should shuffle the cards into a random order" do
      @current_deck = @pitch.deck.cards.clone
      @match_result = @current_deck <=> @pitch.deck.shuffle_cards!
      @match_result.should_not == 0
    end

    it "should have four players" do
      @pitch.players.length.should == 4
    end

    it "should know which player has the current dealer" do
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
  describe "when accepting bids" do
    before(:each) do
      bids = { @pitch.player1 => 2, @pitch.player2 => nil, @pitch.player3 => 4, @pitch.player4 => 2}
      @pitch.accept_bids bids
    end

    it "should know the team of the accepted bid" do
      @pitch.current_high_bid["player"].should == @pitch.player3
    end

    it "should disregard all bids but the highest one" do
      @pitch.current_high_bid["bid_value"].should == 4
    end
  end
  describe "when creating the player order for the round" do
    it "should order correctly when Player1 has the high bid" do
      @pitch.current_high_bid = { "player" => @pitch.player1}
      @pitch.set_round_player_order
      @pitch.current_round_player_order.should == [@pitch.player1, @pitch.player2, @pitch.player3, @pitch.player4]
    end

    it "should order correctly when Player1 has the high bid" do
      @pitch.current_high_bid = { "player" => @pitch.player2}
      @pitch.set_round_player_order
      @pitch.current_round_player_order.should == [@pitch.player2, @pitch.player3, @pitch.player4, @pitch.player1]
    end

    it "should order correctly when Player1 has the high bid" do
      @pitch.current_high_bid = { "player" => @pitch.player3}
      @pitch.set_round_player_order
      @pitch.current_round_player_order.should == [@pitch.player3, @pitch.player4, @pitch.player1, @pitch.player2]
    end

    it "should order correctly when Player1 has the high bid" do
      @pitch.current_high_bid = { "player" => @pitch.player4}
      @pitch.set_round_player_order
      @pitch.current_round_player_order.should == [@pitch.player4, @pitch.player1, @pitch.player2, @pitch.player3]
    end
  end

  describe "when declaring trump" do
    before(:each) do
      @pitch.current_high_bid = { "player" => @pitch.player3}
    end

    it "should be able to with the winning bidder" do
      @pitch.declare_trump @pitch.player3, "H"
      @pitch.trump.should == "H"
    end

    it "should not be able to with a player that is not the winning bidder" do
      @pitch.declare_trump @pitch.player2, "H"
      @pitch.trump.should_not == "H"
    end
  end
end

