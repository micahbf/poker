require_relative 'card'

class Deck
  attr_reader :cards

  def initialize
    build_deck
  end

  def build_deck
    @cards = []
    Card::SUITS.each do |suit|
      Card::VALUES.each do |value|
        @cards << Card.new(value, suit)
      end
    end
  end
  
  def count
    @cards.count
  end

  def shuffle!
    @cards.shuffle!
  end

  def deal(num_cards)
    @cards.pop(num_cards)
  end
end