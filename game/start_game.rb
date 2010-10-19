require './pitch'

#start game
pitch = Pitch.new

#collect bids
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

#assign trump
bid_winner = pitch.current_high_bid["player"]
puts "#{bid_winner.name}, select trump(H,D,S,C):"
STDOUT.flush
pitch.trump = gets.chomp
puts "Trump is #{pitch.trump}"

#collect cards for round 1
currently_played_cards = {}
puts "#{bid_winner.name}, it is your lead. Please lead with a trump card"
pitch.current_round_player_order.each do |player|
  puts "#{player.name} available cards: #{player.cards}"
  STDOUT.flush
  currently_played_cards[player] = gets.chomp
end

#calculate and output current turn results
pitch.calculate_results currently_played_cards

