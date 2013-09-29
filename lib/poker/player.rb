class Player
  attr_accessor :hand, :stash

  def initialize(starting_stash)
    @stash = starting_stash
    @name = get_name
    @hand = nil
  end

  def bet(money_in, to_match, pot)
    #TODO: side pots/all in
    puts "Player: #{@name}"
    puts "Stash: #{@stash} Money in: #{money_in} To match: #{to_match} Pot: #{pot}"
    options = []
    options += ["[C]heck","[B]et [amount]"]  if to_match - money_in == 0
    options += ["[C]all", "[R]aise [amount]"] if to_match - money_in > 0
    options << "[F]old"
    
    begin
      print "> "
      action, amount = gets.chomp.upcase.split
      valid_actions = options.map { |o| o[1] }
      raise "Invalid action" unless valid_actions.include?(action)
      raise "Specify amount" if ["B", "R"].include?(action) && amount.nil?
      raise "You don't have that much" if amount && amount.to_i > @stash
      raise "You must bet more" if action == "R" && money_in + amount <= to_match
    rescue StandardError => error
      puts "#{error}, try again."
      retry
    end
    
    amount = amount.to_i if amount
    
    case action
    when "F"
      return false
    when "C"
      new_bet = to_match - money_in
      @stash -= new_bet
      return new_bet
    when "B"
      @stash -= amount
      return amount
    when "R"
      new_bet = (to_match - money_in) + amount
      @stash -= new_bet
      return new_bet
    end
  end
    
  def discard
    puts "Player: #{@name}"
    "Pick up to three cards to discard. e.g. 1, 2, 5"
    puts @hand.render
    print = "> "
    discards = gets.chomp.split(/\s*,\s*/).map(&:to_i)
    @hand.discard(discards)
    
    discards.count
  end
  
  private
  
  def get_name
    puts "Enter player name"
    print "> "
    gets.chomp
  end
end