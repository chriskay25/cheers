class Cheers::Scraper
  
  def breweries
    # Stores the HTML in the 'page' variable 
    page = Nokogiri::HTML(open("https://www.beeradvocate.com/place/city/1/"))
    
    # Selects the text we want and returns an array of arrays, formatted [["Brewery Name", "Brewery Address"],["Brewery Name", "Brewery Address"],..]
    page.css("div#ba-content ul li").map {|brewery| brewery.text}.map {|info| info.split(" - ")}
  end 
  
end 
    