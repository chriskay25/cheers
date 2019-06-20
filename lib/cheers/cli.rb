# CLI Controller - responsible for user interactions (ex. welcoming user, dealing with inputs, etc.)

class Cheers::CLI
  
  def call 
    greeting
    make_breweries
  end 
  
  def greeting 
    puts "Welcome. This CLI includes information about breweries in Downtown Atlanta."
  end 
    
    # input = nil 
    # while input != "exit" 
    #   input = gets.strip.downcase 
    #     puts "That is not a valid option, please try again"

  def make_breweries
    #Scrapes the breweries page and creates brewery objects.
    Cheers::Scraper.breweries.each do |brewery_hash|
      Cheers::Brewery.new(brewery_hash) 
    end 
    puts "Enter the corresponding number of the brewery to learn more:"
    Cheers::Brewery.all.each.with_index(1) do |brewery, index|
      puts "#{index}. #{brewery.name} - #{brewery.address}"
    end 
  end 
  
end 