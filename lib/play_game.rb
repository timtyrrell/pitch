# encoding: utf-8
require './pitch'
require './screen_util.rb'

pitch = Pitch.new

bids = {}
pitch.players.each do |player|
  ScreenUtil.clear
  unless bids.length == 0
    puts "***Current Bids***"
  end
  bids.each do |player, bid|
    puts "#{player.name} has bid: #{bid}"
  end
  puts ""
  puts "Your current cards: #{player.cards}"
  puts ""
  puts "#{player.name}, enter your bid (2 to 5):"
  STDOUT.flush
  bids[player] = gets.chomp.to_i
end

#accept bids and trump
ScreenUtil.clear
pitch.accept_bids bids
puts pitch.trump
bid_winner = pitch.current_high_bid['player']
card_suit = ['H','D', 'S', 'C']
puts "#{bid_winner.name}, enter the number to the left of the card to declare it as trump:"
puts "Your current cards: #{bid_winner.cards}"
puts ""
puts "1 -- ♥"
puts "2 -- ♦"
puts "3 -- ♠"
puts "4 -- ♣"
STDOUT.flush
trump_selection = gets.chomp.to_i
pitch.declare_trump bid_winner, card_suit[trump_selection - 1]

#collect cards for round 1
ScreenUtil.clear
currently_played_cards = {}
puts "#{bid_winner.name}, it is your lead. Please lead with a trump card"
pitch.current_round_player_order.each do |player|
  ScreenUtil.clear
  puts "Current Trump: #{pitch.trump}"
  unless currently_played_cards.empty?
    puts "****"
    currently_played_cards.each do |player, card|
      puts "Currently played cards: #{player.name} -- #{card}"
    end
    puts "****"
  end
  puts ""
  puts "#{player.name}, enter the number to the left of the card to play it:"

  card_count = 1
  player.cards.each do |card|
    puts "#{card_count} -- #{card}"
    card_count += 1
  end

  STDOUT.flush
  number_selected = gets.chomp.to_i
  currently_played_cards[player] = player.cards[number_selected-1]
  player.cards.delete_at(number_selected-1)
end
ScreenUtil.clear

#calculate and output current turn results
winning_player = pitch.calculate_round_winner currently_played_cards
puts "#{winning_player.name} on #{winning_player.team} won the hand!"

