class TowersOfHanoi

  attr_reader :towers

  def initialize(num_discs)
    @towers = [[],[],[]]
    (1..num_discs).each { |disc| @towers[0].unshift(disc) }
  end

  def move(from_tower, to_tower)
    raise "nothing to move" if @towers[from_tower].empty?

    if !@towers[to_tower].empty? && @towers[to_tower].last < @towers[from_tower].last
      raise "can't move a disc on to a smaller disc"
    end

    @towers[to_tower] << @towers[from_tower].pop
  end

  def render
    p @towers
  end

  def won?
    return true if @towers[2] == [3,2,1]
    false
  end
end


