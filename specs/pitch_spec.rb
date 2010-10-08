require File.dirname(__FILE__) + '/../game/pitch'

describe "Pitch game testing" do
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

