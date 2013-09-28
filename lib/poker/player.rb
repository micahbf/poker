class Player
  attr_accessor :hand

  def initialize
  end

  def bet_turn

  end

  def discard
    "Pick up to three cards to discard. (1,2,3,4,or 5)"
    @hand.display_hand
    discards = gets.chomp.split(",").map(&:to_i)
    discards.each do |card_index|
      @hand[card_index - 1] = nil
    end
    @hand.compact
  end

  def add_card(card)
    @hand << card
  end
end