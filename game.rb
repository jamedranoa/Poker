class Game
  def initialize(*players,deck)
    @players = [*players]
    @players_round = @players.dup
    @deck = Deck.new
    @pot = 0
    @current_bet = 0
  end
  
  def round
    deal_cards
    place_bets
    show_card
    pick_pay_winner
  end
  
  def play
    while @players_round.count > 1
      delete_broke_players
      round
      @players_round.rotate!
    end
    display_winner
  end
  
  def deal_cards
    @players_round.each {|player| player.deal_from(@deck)}
  end
  
  def place_bets
    @players_round.each_with_index do |player,i|
      if i = 1
        @current_bet = player.first_bet
        @pot += @current_bet
        next
      end
      player.make_bet
    end
  end
  
  def change_cards
    @players_round.each do |player|
      player.make_change
    end
  end
  
  def show_cards
    @players_round.each do |player|
      puts players.cards
    end
  end
  
  def pick_pay_winner
    winner = @players_round.first
    @players_round.each_with_index do |player,i|
      next if  i = 1
      winner = player if player.beats?(winner)
    end
    p "you win #{winner.name} an amount of #{@pot}"
    winner
  end
  
  def display_winner
    p "you are the winner #{@player.last.name}"
    p "you have now #{@player.last.bankroll}"
    p "congrats"
  end
    
end
    
    