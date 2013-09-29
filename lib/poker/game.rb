require_relative 'player'
require_relative 'deck'

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
    
      deal_new_hands(deck)
      
      catch :round_over do
        pot += betting_round(active_players)

        active_players.each do |player|
          discarded_count = player.discard.count
          player.hand << deck.deal(discarded_count)
        end
      
        pot += betting_round(active_players)
      end
      
      winners = winners(active_players)
      reveal_hands(active_players)
      win_message(winners)

      winners.each do |winner|
        winner.stash += pot / winners.count
      end
      
      @players.delete_if { |p| p.stash == 0 }
    end
  end
  
  private
  
  def betting_round(active_players)
    last_raiser = nil
    to_match = 0
    money_in = Hash.new(0)
    
    catch :done do
      until active_players.count == 1
        active_players.each do |player|
          throw :done if player == last_raiser
        
          curr_pot = money_in.values.inject(:+)
          player_bet = player.bet(money_in[player], to_match, curr_pot)
        
          if player_bet
            money_in[player] += player_bet
            to_match += player_bet - to_match if player_bet - to_match > 0
          else
            active_players.delete(player)
          end
        
          throw :round_over if active_players.count == 1
          last_raiser = player if player_bet && player_bet > 0
          last_raiser ||= player
        end
      end
    end
    money_in.values.inject(:+)
  end
  
  def deal_new_hands(deck)
    @players.each do |player|
      player.hand = Hand.new(deck.deal(5))
    end
  end
  
  def winners(active_players)
    active_players.sort! { |p1, p2| p1.hand <=> p2.hand }
    winners = []
    split = 1
    active_players.reverse.each_with_index do |player, index|
      next if index == active_players.count - 1
      winners << player
      break unless player.hand == active_players[index + 1].hand
    end
    winners
  end
  
  def reveal_hands(active_players)
    active_players.each do |player|
      puts "#{player.name}: #{player.hand.hand_type[0]} > #{player.hand.render}"
    end
  end
  
  def win_message(winners)
    names = winners.map { |w| w.name }
    case winners.count
    when 1
      puts "#{names[0]} wins!"
    when 2
      puts "#{names[1]} and #{names[1]} split the pot!"
    else
      puts "#{names[0..-2].join(", ")} and #{names[-1]} split the pot!"
    end
  end
end


if __FILE__ == $PROGRAM_NAME
  g = Game.new(3, 500)
  g.play
end
  
