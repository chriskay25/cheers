class Cheers::Scraper
  
  def page
    #Returns the HTML from the website
    Nokogiri::HTML(open("https://www.beeradvocate.com/place/city/1/"))
  end 

  def breweries 
    # Uses the page method to get HTML, grabs content from first ul, then selects the text we want from the li's 
    # and splits it to return an array of arrays, formatted [["Brewery Name", "Brewery Address"],["Brewery Name", "Brewery Address"],..]
    page.css("div#ba-content ul").first.css("li").map {|li| li.text}.map {|brewery| brewery.split(" - ")}
  end 
  
  def brewery_links 
    # Returns an array of links to the individual breweries info pages. Format is ["/beer/profile/46938"]
    page.css("div#ba-content ul").first.css("li a").map {|a| a.attribute("href").value}
  end 

  # def brews 
  #   #Need a way to scrape the individual beers, whose links are on the original page listing breweries.
  #   breweries.each do {|brewery| brewery}
  # end
  
end 
    