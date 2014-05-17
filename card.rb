class String
  def red
    "\033[31m#{self}\033[0m" 
  end 
end


class Card
  SUIT_STRINGS = {
    :clubs    => "♣",
    :diamonds => "♦",
    :hearts   => "♥",
    :spades   => "♠"
  }
  
    VALUES = {
    :two => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => :J,
    :queen => :Q,
    :king  => :K, 
    :ace   => :A
  }
  
  SUITS = {
      :clubs    => "♣",
      :diamonds => "♦",
      :hearts   => "♥",
      :spades   => "♠"
    }
  
  def to_s
    output = "[#{VALUES[self.value].to_s} #{SUIT_STRINGS[self.suit]}]"
    
    if self.suit == :diamonds || self.suit == :hearts
      output.red
    else
      output
    end
  end 
  
  def self.suits
    SUITS.keys
  end
  
  def self.values
    VALUES.keys
  end
  
  attr_reader :suit, :value
  
  def initialize(suit, value)
    unless Card.suits.include?(suit) && Card.values.include?(value)
      raise "Illegal suit/value"
    end
    
    @suit, @value = suit, value
  end
end


