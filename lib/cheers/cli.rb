# CLI Controller - responsible for user interactions (ex. welcoming user, dealing with inputs, etc.)

class Cheers::CLI
  
  def call 
    greeting
    make_breweries
    brewery_choice 
    make_beer
    farewell
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
    puts "  Enter the corresponding number of the brewery to see their beer list:".upcase.light_yellow
    Cheers::Brewery.all.each.with_index(1) do |brewery, index|
      puts "#{index.to_s.light_white}. #{brewery.name.upcase.light_green} --- #{brewery.address.cyan}"
    end
    
    input = nil 
    while input != "exit"
      input = gets.to_i
      if input < 1 || input > Cheers::Brewery.all.count
        puts "Sorry, that's not a valid input, please enter a valid brewery number:"
      end 
      Cheers::Brewery.all.each do |brewery|
        if input == brewery.index 
          make_beer(brewery) 
        end 
      end 
      self.farewell
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

  def farewell 
    puts "Would you like to see the list of breweries again? (y/n)".yellow
    puts "--------------------------------------------------------"
    input = gets.chomp
    until input == "y" || input == "n"
      puts "That is not a valid option, would you like to see the list of breweries again? (y/n)"
    end 
    if input == "y"
      brewery_choice 
    elsif input == "n"
      puts "Thank you for using this CLI, I hope you found some tasty options!".light_blue 
      puts "------------------------------------------------------------------".light_white
    end  
  end 

end  