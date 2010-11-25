# encoding: utf-8
require File.dirname(__FILE__) + '/../lib/pitch'
require File.dirname(__FILE__) + '/../lib/screen_util'

pitch = Pitch.new

bids = ScreenUtil.input_bids(pitch)

bid_winner = ScreenUtil.accept_bids_and_declare_winner(pitch, bids)

trump_selection = ScreenUtil.bid_winner_declares_trump(pitch, bid_winner)

pitch.declare_trump(bid_winner, pitch.deck.card_suit[trump_selection - 1])

#collect cards for round 1
played_cards = ScreenUtil.collect_cards(pitch, bid_winner)

#calculate and output current turn results
winning_player = pitch.calculate_round_winner(played_cards)
puts "#{winning_player.name} on #{winning_player.team} won the hand!"

