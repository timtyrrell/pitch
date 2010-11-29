module Pitch
  module ScoreCalculator
    extend self

    @current_high_player_and_card = {}
    @leading_suit = ""
    @current_high_card_value = ""
    @current_high_card_suit = ""
    @card_pile = []
    @card_valie = ""
    @card_suit = ""

    def calculate_round_winner(game, played_cards)
      set_initial_high_card(played_cards)

      played_cards.each do |player, card|
        set_current_high_card(card)

        #trump always wins against non-trump
        if @card_suit == game.trump and @current_high_card_suit != game.trump
          @current_high_player_and_card = {"player" => player, "card" => card}
        #trump vs. trump comparison
        elsif @card_suit == @leading_suit and game.card_value_lookup[@card_value] > game.card_value_lookup[@current_high_card_value] and @card_suit == game.trump and @current_high_card_suit == game.trump
          @current_high_player_and_card = {"player" => player, "card" => card}
        #non-trump vs. non-trump comparison
      elsif @card_suit == @leading_suit and game.card_value_lookup[@card_value] > game.card_value_lookup[@current_high_card_value] and @card_suit != game.trump and @current_high_card_suit != game.trump
          @current_high_player_and_card = {"player" => player, "card" => card}
        end
      end

      assign_to_pile(game)

      return @current_high_player_and_card["player"]
    end

    private
      def set_initial_high_card(played_cards)
        #set first player and card as high
        @current_high_player_and_card = {"player" => played_cards.first.first, "card" => played_cards.first.last}
        #set first card value as high
        @current_high_card_value = @current_high_player_and_card["card"].chop
        #set first card suit as leading suite and high card suit
        @leading_suit = current_high_card_suit = @current_high_player_and_card["card"][-1]
      end

      def set_current_high_card(card)
        @card_pile << card
        #get player's card value and suit
        @card_value = card.chop
        @card_suit = card[-1]
        #get current high card value and suit
        @current_high_card_value = @current_high_player_and_card["card"].chop
        @current_high_card_suit = @current_high_player_and_card["card"][-1]
      end

      def assign_to_pile(game)
        if @current_high_player_and_card["player"].team == "team1"
        game.team1_card_pile << @card_pile
        else
          game.team2_card_pile << @card_pile
        end
      end
  end
end

