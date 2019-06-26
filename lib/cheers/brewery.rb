class Cheers::Brewery 
  
  attr_accessor :name, :address, :beer, :url, :index, :beer_count
  @@all = []

  def initialize(attribute_hash) 
    attribute_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
    @beer = []
  end 

  def assign_beer
    # @beer = []
    Cheers::Beer.all.each do |beer| 
      if beer.brewery == self 
        @beer << beer
      end 
    end 
  end 

  def self.all
    @@all 
  end 
  
end 