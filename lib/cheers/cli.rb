class Cheers::CLI

  def call
    greeting
    make_breweries
    brewery_choice
  end

  def greeting
    puts "\n Welcome! This CLI includes information about breweries in Downtown Atlanta.".upcase.yellow
  end

  def make_breweries
    Cheers::Scraper.breweries.each do |brewery_hash|
      Cheers::Brewery.new(brewery_hash)
    end
  end

  def brewery_choice
    puts "\n Enter the corresponding number of a brewery to see their beer list:".light_white
    puts "---------------------------------------------------------------------".light_white
    Cheers::Brewery.all.each.with_index(1) do |brewery, index|
      puts "#{index.to_s.light_white}. #{brewery.name.upcase.light_green} --- #{brewery.address.cyan}"
    end

    # Check for valid user input
    input = gets.to_i
    until input > 0 && input <= Cheers::Brewery.all.count
      puts "Please enter a valid number:".light_red
      input = gets.to_i
    end

    Cheers::Brewery.all.each do |brewery|
      if input == brewery.index && brewery.beer.empty?
        make_beer(brewery)
      elsif input == brewery.index && brewery.beer.count > 0
        beer_list(brewery)
      end
    end
  end

  def make_beer(brewery)
    Cheers::Scraper.brewery_page(brewery).each {|beer_hash| Cheers::Beer.new(beer_hash)}
    brewery.assign_beer
    beer_list(brewery)
  end

  def beer_list(brewery)
    puts "\n     ------ #{brewery.name.upcase} BEER LIST -- #{brewery.beer.count} BREWS AVAILABLE ------".light_yellow
    brewery.beer.each.with_index(1) do |beer, index|
      puts "#{index}. ".light_white + "#{beer.name.upcase.light_green} " + "| --- | ".light_blue + "STYLE: ".light_white + "#{beer.style.light_cyan}" + " | --- | ".light_blue + "ABV: ".light_white + "#{beer.abv.to_s.light_cyan}%".light_cyan + " | --- | ".light_blue + "RATING: ".light_white + "#{beer.rating.to_f}/5".light_cyan
      (beer.name.length + 4).times {print "-".light_yellow}
      puts
    end
    farewell
  end

  def farewell
    input = nil
    until input == "y" || input == "n"
      puts "Would you like to see the list of breweries again? (y/n)".light_white
      input = gets.strip.downcase
    end

    if input == "y"
      brewery_choice
    elsif input == "n"
      puts "-------------------------------------------------------"
      puts "Thanks, I hope you found some tasty options!".light_yellow
      puts "-------------------------------------------------------".light_white
      exit
    end
  end

end