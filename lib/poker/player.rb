class Player
  attr_accessor :hand, :stash

  def initialize(starting_stash)
    @stash = starting_stash
    @name = get_name
    @hand = nil
  end

  def bet_turn

  end

  def discard
    "Pick up to three cards to discard. (1 - 5)"
    @hand.display_hand
    discards = gets.chomp.split(",").map(&:to_i)
    discards.each do |card_index|
      @hand[card_index - 1] = nil
    end
    @hand.compact!
  end

  def add_card(card)
    @hand << card
  end
  
  private
  
  def get_name
    puts "Enter player name"
    print "> "
    gets.chomp
  end
end