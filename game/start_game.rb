require './pitch'

pitch = Pitch.new

#TODO: display all bids by players
bids = {}
pitch.players.each do |player|
  puts "State your bid (2 to 5):"
  STDOUT.flush
  #TODO regex for limited numbers
  #TODO comparison to see if greater than other bids
  bids[player] = gets.chomp.to_i
end

pitch.accept_bids bids

