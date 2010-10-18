require './pitch'

pitch = Pitch.new

bids = {}
pitch.players.each do |player|
  puts "#{player.name}, your bid (2 to 5)?"
  STDOUT.flush
  #TODO regex for limited numbers
  #TODO comparison to see if greater than other bids
  #TODO: display all bids by players
  bids[player] = gets.chomp.to_i
end

pitch.accept_bids bids

bid_winner = pitch.current_high_bid["player"]

puts "#{bid_winner.name}, select trump(H,D,S,C):"
STDOUT.flush
pitch.trump = gets.chomp
puts "Trump is #{pitch.trump}"

puts "#{bid_winner.name}, it is your lead. Play a trump card:"

#each player starting with the bid winner plays a card

STDOUT.flush
#pitch.current_hand = { player => gets.chomp}

