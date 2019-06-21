class Cheers::Beer 
  
  attr_accessor :name, :style, :abv 
  
  def initialize(attribute_hash) 
    attribute_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end 
  
end 