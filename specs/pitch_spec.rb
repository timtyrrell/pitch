require 'pitch'

describe Pitch do
  before(:each) do
    @pitch = Pitch.new
  end
  describe "when starting a game of pitch" do
    it "should have 52 cards" do
      @pitch.length.should==52
    end
  end
end

