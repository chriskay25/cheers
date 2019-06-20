# CLI Controller - responsible for user interactions (ex. welcoming user, dealing with inputs, etc.)

class Cheers::CLI
  
  def call 
    greeting
    options 
  end 
  
  def greeting 
    puts "Welcome. This CLI includes information about breweries in Downtown Atlanta as well as the beer they sell."
  end 
  
  def options 
    puts "To select one of the following options, type its corresponding number and press 'Enter':"
    puts <<-DOC 
      1. I want a list of Atlanta breweries
      2. I already have a brewery in mind, show me their beer
      3. Beer ye, beer ye
    DOC
    
    input = nil 
    while input != "exit" 
      input = gets.strip.downcase 
      if input == "1"
        self.make_breweries
      elsif input == "2"
        puts "These are the beers sold at this location"
      elsif input == "3" 
        puts "Info about beer"
      else 
        puts "That is not a valid option, please try again"
      end 
    end 
  end 

  def make_breweries
    Cheers::Scraper.breweries.each do |brewery_hash|
      Cheers::Brewery.new(brewery_hash) 
    end 
  end 
  
end 