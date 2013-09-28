class Card
  attr_reader :value, :suit

  VALUES = (2..14).to_a

  FACE_CARDS = {
    11 => :J,
    12 => :Q,
    13 => :K,
    14 => :A,
    1 => :A
  }



  def initialize(value, suit)
    @value = value
    @suit = suit
  end


end