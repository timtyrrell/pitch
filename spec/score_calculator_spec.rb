$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
require 'pitch'

describe "when calculating the hand winner" do
  before(:each) do
    @pitch = Pitch::Game.new
    @pitch.start_round
    @pitch.trump = "H"
  end
  it "should have a low trump card beats any other higher card of another suit" do
    currently_played_cards = { @pitch.player1 => "AD", @pitch.player2 => "2H", @pitch.player3 => "4C", @pitch.player4 => "8D"}
    result = Pitch::ScoreCalculator.calculate_round_winner(@pitch, currently_played_cards)
    result.name.should == "Player2"
  end
  it "should have a non-trump high card beats a lower non-trump card" do
    currently_played_cards = { @pitch.player1 => "4C", @pitch.player2 => "2C", @pitch.player3 => "8C", @pitch.player4 => "3C"}
    result = Pitch::ScoreCalculator.calculate_round_winner(@pitch, currently_played_cards)
    result.name.should == "Player3"
  end
  it "should have a non-trump face card beats a lower non-trump face card" do
    currently_played_cards = { @pitch.player1 => "3C", @pitch.player2 => "QC", @pitch.player3 => "JC", @pitch.player4 => "3C"}
    result = Pitch::ScoreCalculator.calculate_round_winner(@pitch, currently_played_cards)
    result.name.should == "Player2"
  end
  it "should have a trump high card beats a lower trump card" do
    currently_played_cards = { @pitch.player1 => "4H", @pitch.player2 => "2H", @pitch.player3 => "8H", @pitch.player4 => "3H"}
    result = Pitch::ScoreCalculator.calculate_round_winner(@pitch, currently_played_cards)
    result.name.should == "Player3"
  end
  it "should have a trump face card beats a lower trump face card" do
    currently_played_cards = { @pitch.player1 => "3H", @pitch.player2 => "QH", @pitch.player3 => "JH", @pitch.player4 => "3H"}
    result = Pitch::ScoreCalculator.calculate_round_winner(@pitch, currently_played_cards)
    result.name.should == "Player2"
  end
  it "should have a lower card of the current suit beats a higher card of an off suite" do
    currently_played_cards = { @pitch.player1 => "8C", @pitch.player2 => "2C", @pitch.player3 => "9S", @pitch.player4 => "QS"}
    result = Pitch::ScoreCalculator.calculate_round_winner(@pitch, currently_played_cards)
    result.name.should == "Player1"
  end
  it "should set the team1 pile of player1 wins the hand" do
    currently_played_cards = { @pitch.player1 => "2H", @pitch.player2 => "2C", @pitch.player3 => "9S", @pitch.player4 => "QS"}
    Pitch::ScoreCalculator.calculate_round_winner(@pitch, currently_played_cards)
    @pitch.team1_card_pile.should_not be_empty
  end
  it "should set the team2 pile of player4 wins the hand" do
    currently_played_cards = { @pitch.player1 => "3C", @pitch.player2 => "2C", @pitch.player3 => "9S", @pitch.player4 => "QH"}
    Pitch::ScoreCalculator.calculate_round_winner(@pitch, currently_played_cards)
    @pitch.team2_card_pile.should_not be_empty
  end
end

