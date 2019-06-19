class Cheers::Scraper
  
  def page
    #Returns the HTML from the website
    Nokogiri::HTML(open("https://www.beeradvocate.com/place/city/1/"))
  end 

  def breweries 
    # Selects the text we want and returns an array of arrays, formatted [["Brewery Name", "Brewery Address"],["Brewery Name", "Brewery Address"],..]
    # Currently returns breweries and bars/eateries, just want breweries though, so will need to find a way to access just the first "ul".
    page.css("div#ba-content ul li").map {|brewery| brewery.text}.map {|info| info.split(" - ")}
  end 
  
  # def brews 
  #   #Need a way to scrape the individual beers, whose links are on the original page listing breweries.
  #   breweries.each do {|brewery| brewery}
  # end
  
end 
    