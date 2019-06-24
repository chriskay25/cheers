# CLI Controller - responsible for user interactions (ex. welcoming user, dealing with inputs, etc.)

class Cheers::CLI
  
  def call 
    greeting
    make_breweries
    brewery_choice 
    make_beer
  end 
  
  def greeting 
    puts "Welcome! This CLI includes information about breweries in Downtown Atlanta.".upcase.yellow
  end 

  def make_breweries
    #Scrapes the breweries page and creates brewery objects.
    Cheers::Scraper.breweries.each do |brewery_hash|
      Cheers::Brewery.new(brewery_hash) 
    end 
  end 

  def brewery_choice
    puts "  Enter the corresponding number of the brewery to learn more:".upcase.light_yellow
    Cheers::Brewery.all.each.with_index(1) do |brewery, index|
      puts "#{index.to_s.light_white}. #{brewery.name.upcase.light_green} --- #{brewery.address.cyan}"
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
    Cheers::Scraper.brewery_page(brewery).each do |beer_hash|
      Cheers::Beer.new(beer_hash)
    end 
    brewery.assign_beer 
    puts "       ------ #{brewery.name.upcase} BEER LIST ------".light_yellow
    brewery.beer.each.with_index(1) do |beer, index|
      puts "#{index}. ".light_white + "#{beer.name.upcase.light_green} " + "| --- | ".light_blue + "STYLE: ".light_white + "#{beer.style.light_cyan}" + " | --- | ".light_blue + "ABV: ".light_white + "#{beer.abv.to_s.light_cyan}" + "%".light_cyan
      (beer.name.length + 4).times {print "-".light_yellow}
      puts
    end 
  end  

end  