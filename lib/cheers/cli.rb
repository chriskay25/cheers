# CLI Controller - responsible for user interactions (ex. welcoming user, dealing with inputs, etc.)

class Cheers::CLI
  
  def call 
    greeting
    make_breweries
    brewery_choice 
  end 
  
  def greeting 
    puts "Welcome. This CLI includes information about breweries in Downtown Atlanta."
  end 

  def make_breweries
    #Scrapes the breweries page and creates brewery objects.
    Cheers::Scraper.breweries.each do |brewery_hash|
      Cheers::Brewery.new(brewery_hash) 
    end 
  end 

  def brewery_choice
    puts "Enter the corresponding number of the brewery to learn more:"
    Cheers::Brewery.all.each.with_index(1) do |brewery, index|
      puts "#{index}. #{brewery.name} - #{brewery.address}"
    end
    
    input = nil 
    while input != "exit"
      input = gets.to_i
      Cheers::Brewery.all.each do |brewery|
        if input == brewery.index 
          make_beer(brewery)
        end 
      end 
    end 
  end 
  
  def make_beer(brewery)
    beer_hashes = Cheers::Scraper.brewery_page(brewery)
      beer_hashes.each {|beer_hash| Cheers::Beer.new(beer_hash)}
  end 

end  