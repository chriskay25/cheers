class Cheers::Beer 
  
  attr_accessor :name, :style, :strength 
  
  def self.all_the_beer
    # gathers and returns a list of beers and their properties
    [{}]
    beer1 = self.new 
    beer1.name = "Stouty McStouterson"
    beer1.style = "Stout"
    beer1.strength = "5.2%"
    
    beer2 = self.new 
    beer2.name = "Porty McPorterson"
    beer2.style = "Porter" 
    beer2.strength = "6.6%"
    
    [beer1, beer2]
  end 
  
end 