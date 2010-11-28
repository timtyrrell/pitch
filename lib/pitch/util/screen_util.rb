# encoding: utf-8

module Pitch
  module Util
    module ScreenUtil
      extend self

      def clear
        puts "\e[H\e[2J" # clear the screen
      end

      def input_bids(pitch)
        bids = {}
        pitch.players.each do |player|
          Pitch::Util::ScreenUtil.clear
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
        bids
      end

      def accept_bids_and_declare_winner(pitch, bids)
        Pitch::Util::ScreenUtil.clear
        pitch.accept_bids bids
        puts pitch.trump
        pitch.current_high_bid['player']
      end

      def bid_winner_declares_trump(pitch, bid_winner)
        card_suit = ['H','D', 'S', 'C']
        puts "#{bid_winner.name}, enter the number to the left of the card to declare it as trump:"
        puts "Your current cards: #{bid_winner.cards}"
        puts ""
        puts "1 -- ♥"
        puts "2 -- ♦"
        puts "3 -- ♠"
        puts "4 -- ♣"
        STDOUT.flush
        gets.chomp.to_i
      end

      def collect_cards(pitch, bid_winner)
        Pitch::Util::ScreenUtil.clear
        currently_played_cards = {}
        puts "#{bid_winner.name}, it is your lead. Please lead with a trump card"
        pitch.current_round_player_order.each do |player|
          Pitch::Util::ScreenUtil.clear
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
        Pitch::Util::ScreenUtil.clear
        currently_played_cards
      end

    end
  end
end

