# encoding: utf-8
$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
require 'pitch'

game = Pitch::Game.new

bids = Pitch::Util::ScreenUtil.input_bids(game)

bid_winner = Pitch::Util::ScreenUtil.accept_bids_and_declare_winner(game, bids)

trump_selection = Pitch::Util::ScreenUtil.bid_winner_declares_trump(game, bid_winner)

game.declare_trump(bid_winner, game.deck.card_suit[trump_selection - 1])

#collect cards for round 1
played_cards = Pitch::Util::ScreenUtil.collect_cards(game, bid_winner)

#calculate and output current turn results
winning_player = game.calculate_round_winner(played_cards)
puts "#{winning_player.name} on #{winning_player.team} won the hand!"

