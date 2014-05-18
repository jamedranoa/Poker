class Player
  def initialize(name,bank)
    @name = name
    @bank = bank
  end
  
  attr_accessor :hand,:g,:name
  
  def set_game(g)
    @g = g
  end
  
  def deal_from(deck)
    self.hand = Hand.deal_from(deck)
  end
  
  def first_bet
    print hand
    p "what is your bet?"
    bet = translate_bet(gets)
    @bank -= bet
    bet
   
  end
  
  def make_bet 
    g.display_current
    print hand
    p "Do you want to [f]old,[r]aise or [s]ee the curren bet"
    decision = translate(gets)
    analize(decision)
  end
  
  def analize(decision)
    return make_fold if decision == "f"
    return make_rise if  decision == "r"
    g.pot += g.current_bet
    @bank -= g.current_bet
    g.raising = false
  end
  
  def make_fold
    g.raising = false
    g.delete_me(self)
  end
  
  def make_rise()
    begin
      g.raising = true
      p "What is your bet"
      bet = translate_bet(gets)
      raise "That is less than the current bet" if bet < g.current_bet
    rescue  => e
      p e.message
      p "try again"
      puts
      retry
    end
    g.current_bet = bet
    g.pot += bet
    @bank -= bet
  end
  
  def translate_bet(str)
    str.chomp.scan(/\d+/).join("").to_i
  end
  
  def translate(str)
    str.chomp.split("").first
  end
  
  def make_change
    changes = ask_for_change
    cards_to_change = []
    changes.each do |index| 
      cards_to_change << hand.cards[index]
    end
    hand.return_cards(g.deck,cards_to_change)
    hand.cards -= cards_to_change
    hand.cards += g.deck.take(changes.count)
  end
  
  def ask_for_change
    p "what cards do you want gto change"
    gets.chomp.split(",").map(&:to_i)
  end
  
  def beats?(player2)
    self.hand.beats?(player2.hand)
  end
  
  def broke?
    @bank <= 0
  end
  
end
  