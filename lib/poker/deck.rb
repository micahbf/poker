class Deck
  attr_reader :cards

  def initialize
    build_deck
  end

  def build_deck
    values = (2..10).to_a + [:J, :Q, :K, :A]


    suits = [:S, :C, :H, :D]

    @cards = []
    suits.each do |suit|
      values.each do |value|
        @cards << Card.new(value, suit)
      end
    end
  end

  def shuffle!
    @cards.shuffle!
  end

  def deal(num_cards)
    @cards.pop(num_cards)
  end

  def deal_a_card
    @cards.pop
  end

end