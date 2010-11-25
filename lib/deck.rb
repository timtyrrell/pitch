# encoding: utf-8
class Deck
  attr_accessor :cards
  attr_reader :card_suit
  def initialize
     @cards = [
      "2♥","3♥","4♥","5♥","6♥","7♥","8♥","9♥","10♥", "J♥", "Q♥", "K♥", "A♥",
      "2♦","3♦","4♦","5♦","6♦","7♦","8♦","9♦","10♦", "J♦", "Q♦", "K♦", "A♦",
      "2♠","3♠","4♠","5♠","6♠","7♠","8♠","9♠","10♠", "J♠", "Q♠", "K♠", "A♠",
      "2♣","3♣","4♣","5♣","6♣","7♣","8♣","9♣","10♣", "J♣", "Q♣", "K♣", "A♣"
      ]
      @card_suit = ['H','D', 'S', 'C']
  end

  def shuffle_cards!
    cards.shuffle!
  end
end

