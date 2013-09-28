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
      last_raiser = nil
      until active_players.count == 1
        max_bet = 0
        active_players.each do |player|
          break if player == last_raiser
          player_bet = player.bet_turn(max_bet)
          last_raiser = player if player_bet > max_bet
          player_bet ? max_bet = player_bet : active_players.delete(player)
          last_raiser ||= player
        end
      end

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
