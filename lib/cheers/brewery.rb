class Cheers::Brewery 
  
  attr_accessor :name, :address, :brews, :url, :index
  @@all = []

  def initialize(attribute_hash) 
    attribute_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end 

  def create_breweries()
    

  end 

  def self.all
    @@all 
  end 
  
end 