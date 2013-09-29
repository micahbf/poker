class Game
  def initialize(num_players, starting_stash)
    @players = Array.new(num_players) { Player.new(starting_stash) }
  end

  def play
    until @players.count <= 1
      #TODO: side pots
      
      deck = Deck.new
      deck.shuffle!
      pot = 0

      active_players = @players.dup

      @players.each do |player|
        player.hand = Hand.new(deck.deal(5))
      end

      pot += betting_round(active_players)
      if active_players.count == 1
        active_players.first.stash += pot
        next
      end

      active_players.each do |player|
        discarded_count = player.discard.count
        player.hand += deck.deal(discarded_count)
      end
      
      pot += betting_round(active_players)
      if active_players.count == 1
        active_players.first.stash += pot
        next
      end
      
      active_players.sort! { |p1, p2| p1.hand <=> p2.hand }
      winners = []
      split = 1
      active_players.reverse.each_with_index do |player, index|
        next if index == active_players.count - 1
        winners << player
        if player.hand == active_players[index + 1].hand
          split += 1
        else
          break
        end
      end

      winners.each do |winner|
        winner.stash += pot / split
      end
      @players.delete_if { |p| p.stash == 0 }
    end
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
