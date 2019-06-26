# CLI Controller - responsible for user interactions (ex. welcoming user, dealing with inputs, etc.)

class Cheers::CLI
  
  def call 
    greeting
    make_breweries
    brewery_choice 
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
    puts "  Enter the corresponding number of the brewery to see their beer list:".light_white
    Cheers::Brewery.all.each.with_index(1) do |brewery, index|
      puts "#{index.to_s.light_white}. #{brewery.name.upcase.light_green} --- #{brewery.address.cyan}"
    end
    
    input = nil 
    while input != "exit"
      input = gets.to_i
      if input < 1 || input > Cheers::Brewery.all.count
        puts "Sorry, that's not a valid input, please enter a valid brewery number:".light_red
      end 
      Cheers::Brewery.all.each do |brewery|
        if input == brewery.index && brewery.beer.empty?
          make_beer(brewery) 
        elsif input == brewery.index && brewery.beer.count > 0
          beer_list(brewery)
        end 
      end 
    end 
  end 
  
  def make_beer(brewery)
    Cheers::Scraper.brewery_page(brewery).each do |beer_hash|
      Cheers::Beer.new(beer_hash)
    end 
    brewery.assign_beer 
    beer_list(brewery)
  end 

  def beer_list(brewery)
    puts "       ------ #{brewery.name.upcase} BEER LIST ------".light_yellow
    brewery.beer.each.with_index(1) do |beer, index|
      puts "#{index}. ".light_white + "#{beer.name.upcase.light_green} " + "| --- | ".light_blue + "STYLE: ".light_white + "#{beer.style.light_cyan}" + " | --- | ".light_blue + "ABV: ".light_white + "#{beer.abv.to_s.light_cyan}" + "%".light_cyan
      (beer.name.length + 4).times {print "-".light_yellow}
      puts
    end 
    farewell
  end  

  def farewell 
    puts "Would you like to see the list of breweries again? (y/n)".yellow
    puts "--------------------------------------------------------"
    input = gets.chomp
    until input == "y" || input == "n"
      puts "That is not a valid option, would you like to see the list of breweries again? (y/n)".light_red
    end 
    if input == "y"
      brewery_choice 
    elsif input == "n"
      puts "Thank you for using this CLI, I hope you found some tasty options!".light_blue 
      puts "------------------------------------------------------------------".light_white
    end  
  end 

end  