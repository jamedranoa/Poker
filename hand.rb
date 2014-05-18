class Hand
  
  WINNING_HANDS = [
    :high_card,
    :pair,
    :two_pair,
    :three_of_a_kind,
    :straight,
    :flush, #=> 5
    :full_house,
    :four_of_a_kind,
    :straight_flush    
  ]
    
  def self.deal_from(deck)
    Hand.new(deck.take(5))
  end
  
  attr_accessor :cards
  
  def initialize(cards)
    @cards = cards
  end
  
  def card_vals
    Card.values
  end
 
  
  def beats?(other_hand)
    self_points = winning_hand_order.index(self.calculate_points[0])
    other_points = winning_hand_order.index(other_hand.calculate_points[0])
    
    if self_points > other_points
      return true
    elsif self_points == other_points
      self_high = card_vals.index(self.calculate_points[1])
      other_high = card_vals.index(other_hand.calculate_points[1])
      return self_high > other_high ? true :  false
    else
       false
    end
  end
  
  def winning_hand_order
    WINNING_HANDS
  end
  
  def straight?
    possible_straight = @cards.map {|card| card_vals.index(card.value) }.sort
    return true if possible_straight == [:ace,:two,:three,:four,:five]
    possible_straight == (possible_straight[0]..possible_straight[-1]).to_a
  end
  
  def flush?
    @cards.map {|card| card.suit}.uniq.count == 1
  end
  
  def return_cards(deck,cards_array)
    deck.return(cards_array)
    @cards -= cards_array
  end
  
  
  def calculate_points 
    freq_hash = generate_freq_hash
    card_occurences = freq_hash.select { |k,v| v > 1 }.keys
    
    max_freq_card = card_occurences.max_by { |value| card_vals.index(value) }   
    high_card = freq_hash.max_by { |k,v| card_vals.index(k) }.first
  
    if straight? && flush? 
      return [:straight_flush, high_card]
    elsif freq_hash.values.include?(4)
      return [:four_of_a_kind, max_freq_card]
    elsif (freq_hash.values.include?(3)) && (freq_hash.values.include?(2))
      high_triple = freq_hash.select{|k,v| v == 3}.keys.first
      return [:full_house, high_triple]
    elsif flush?
      return [:flush, high_card]
    elsif straight? 
      return [:straight, high_card]
    elsif freq_hash.values.include?(3) 
      return [:three_of_a_kind,max_freq_card]
    elsif freq_hash.keys.count == 3 
      return[:two_pair, max_freq_card]
    elsif freq_hash.keys.count == 4 
      return[:pair, max_freq_card]      
    elsif freq_hash.keys.count == 5
      return[:high_card, high_card ]
    end

  end
  
  def generate_freq_hash
    output = Hash.new() { |h,k| h[k] = 0 }
    
    @cards.each do |card|
      value = card.value
      output[value] += 1      
    end
    
    output
  end
  
  def to_s
   str ="Hand: "
    self.cards.each do |card|
      str << card.to_s
    end
    str
  end
end