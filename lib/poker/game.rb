class Game
  def initialize(num_players)
    @num_players = num_players
    @players = []
    num_players.times do |num|
      @players << Player.new(num)
    end
  end

  def play

    until @players.count <= 1
      deck = Deck.new
      deck.shuffle!

      active_players = @players.dup

      @players.each do |player|
        player.hand = deck.deal_hand
      end

      # => betting loop
      betting_round(active_players)


      # => each player discards
      # => deal new cards

      active_players.each do |active_player|
        discard_count = active_player.discard
        discard_count.times do
          active_player.add_card(deck.deal_a_card)
        end
      end

      # => betting loop
      # => if all but one folds, player gets pot
      # => if no folds, reveal hands and determine winner
      # => distribute pot
      # => kick player out if no money


    end
    # side pots
  end
  
  private
  
  def betting_round(active_players)
    last_raiser = nil
    to_match = 0
    money_in = Hash.new(0)
    
    until active_players.count == 1
      active_players.each do |player|
        break if player == last_raiser
        
        player_bet = player.bet(money_in[player], to_match)
        if player_bet
          raise IllegalBetError if player_bet + money_in[player] < to_match
          money_in[player] += player_bet
          to_match += player_bet
        else
          active_players.delete(player)
        end
        
        last_raiser = player if player_bet > 0
        last_raiser ||= player
      end
    end
    money_in.values.inject(:+)
  end
end
