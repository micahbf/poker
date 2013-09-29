class Card
  attr_reader :value, :suit

  VALUES = (2..14).to_a
  SUITS = [:spades, :clubs, :hearts, :diamonds]
  FACE_CARDS = {
    11 => :jack,
    12 => :queen,
    13 => :king,
    14 => :ace
  }

  def initialize(value, suit)
    @value = value
    @suit = suit
  end
  
  def color
    case @suit
    when :spades, :clubs
      return :black
    when :hearts, :diamonds
      return :red
    end
  end
end