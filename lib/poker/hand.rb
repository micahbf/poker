class Hand
  include Comparable
  
  attr_reader :cards

  HAND_TYPES = [:high_card, :pair, :two_pair, :three_kind, :straight, :flush, :full_house, :four_kind, :straight_flush, :royal_flush]

  def initialize(hand)
    @cards = hand
  end

  def display_hand
    p @cards
  end

  def hand_type
    HAND_TYPES.reverse.each do |hand_type|
      found_hand = send(hand_type)
      return found_hand if found_hand
    end
  end
  
  def <=> (other_hand)
    this_type, this_value = self.hand_type
    other_type, other_value = other_hand.hand_type
    case HAND_TYPES.index(this_type) <=> HAND_TYPES.index(other_type)
    when 1
      return 1
    when -1
      return -1
    when 0
      if this_value.is_a?(Integer)
        return this_value <=> other_value
      elsif (this_value.first <=> other_value.first) != 0
        return this_value.first <=> other_value.first
      elsif (this_value.last <=> other_value.last) != 0
        return this_value.last <=> other_value.last
      else
        return 0
      end
    end
  end
  
  private

  def high_card
    card_values = []
    @cards.each do |card|
      card_values << card.value
    end
    [:high_card, card_values.sort.last]
  end

  def pair
    card_values = []
    @cards.each do |card|
      card_values << card.value
    end

    if card_values.uniq.count == 4
      pair_value = 0
      card_values.sort!.each_with_index do |value, index|
        next if index == card_values.length - 2
        pair_value = value if value == card_values[index + 1]
      end
      return [:pair, pair_value]
    end
    false
  end

  def two_pair
    card_values = []
    @cards.each do |card|
      card_values << card.value
    end

    if card_values.uniq.count == 3
      pair_values = []
      card_values.sort!.each_with_index do |value, index|
        next if index == card_values.length - 2
        pair_values << value if value == card_values[index + 1]
      end
      return [:two_pair, pair_values.sort.reverse]
    end
    false
  end

  def three_kind
    card_values = []
    @cards.each do |card|
      card_values << card.value
    end

    if card_values.uniq.count == 3
      three_kind_value = 0
      card_values.sort!.each_with_index do |value, index|
        next if index == card_values.length - 3
        three_kind_value = value if value == card_values[index + 1] && value == card_values[index + 2]
      end
      return [:three_kind, three_kind_value] unless three_kind_value == 0
    end
    false
  end

  def straight
    card_values = []
    @cards.each do |card|
      card_values << card.value
    end

    if card_values.uniq.count == 5
      is_straight = true
      card_values.sort!.each_with_index do |value, index|
        next if index >= card_values.length - 1
        is_straight = false if value != (card_values[index + 1] - 1)
      end

      return [:straight, 5] if card_values == [2,3,4,5,14]
      return [:straight, card_values.last] if is_straight
    end
    false
  end

  def flush
    suits = []
    @cards.each do |card|
      suits << card.suit
    end

    if suits.uniq.count == 1
      card_values = []
      @cards.each do |card|
        card_values << card.value
      end
      return [:flush, card_values.sort.last]
    end
    false
  end

  def full_house
    card_values = []
    @cards.each do |card|
      card_values << card.value
    end

    full_house_vals = [0,0]

    if card_values.uniq.count == 2
      card_values.each do |val|
        val_count = card_values.select {|v| v == val}.count
        return false if val_count == 1
        full_house_vals[1] = val if val_count == 2
        full_house_vals[0] = val if val_count == 3
      end
      return [:full_house, full_house_vals]
    end
    false
  end

  def four_kind
    card_values = []
    @cards.each do |card|
      card_values << card.value
    end

    four_kind_value = 0

    if card_values.uniq.count == 2
      card_values.each do |val|
        val_count = card_values.select {|v| v == val}.count
        return [:four_kind, val] if val_count == 4
      end
    end
    false
  end

  def straight_flush
    if straight && flush
      return [:straight_flush, straight[1]]
    end
    false
  end

  def royal_flush
    if straight && flush && straight[1] == 14
      return [:royal_flush, straight[1]]
    end
    false
  end
end