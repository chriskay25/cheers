class Cheers::Brewery 
  
  attr_accessor :name, :address, :brews, :url

  def initialize(attribute_hash) 
    attribute_hash.each {|key, value| self.send(("#{key}="), value)}
  end 

  def create_breweries()
    

  end 
  
end 