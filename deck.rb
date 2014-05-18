class Deck
  attr_accessor :cards
  def create_deck
    [].tap do |deck|
      Card.suits.each do |suit|
        Card.values.each do |value|
          deck << Card.new(suit, value)
        end
      end
    end
  end
  
  def initialize
    @cards = create_deck
  end
  
  def count
    @cards.count
  end
  
  def take(n)
    [].tap do |output|
      n.times { output << @cards.shift }
    end
  end
  
  def return(cards)
    cards.each { |card| @cards << card }
  end
  
end