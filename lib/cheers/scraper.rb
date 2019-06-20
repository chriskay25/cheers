class Cheers::Scraper

  @@brewery_list = []
  
  def self.page
    #Returns the HTML from the website
    Nokogiri::HTML(open("https://www.beeradvocate.com/place/city/1/"))
  end 


  def self.breweries 
    # Uses the page method to get HTML, grabs content from first ul, then selects the text from the li's and split it to return an
    # array of arrays, formatted [["Brewery Name", "Brewery Address"], ["Brewery Name", "Brewery Address"]]
    page.css("div#ba-content ul").first.css("li").map {|li| li.text}.map {|brewery| brewery.split("  - ")}.each.with_index(1) do |brewery, index|
      name = brewery[0]
      address = brewery[1] 
      brewery = Hash.new
      brewery[:name] = name 
      brewery[:address] = address 
      brewery[:index] = index 
      brewery[:url] = "https://www.beeradvocate.com" + page.css("div#ba-content ul").first.css("li a").attribute("href").value
      @@brewery_list << brewery
    end
    @@brewery_list
  end 


  def self.brewery_page 
    brewery_links.map do |link| 
      Nokogiri::HTML(open(link))
    end 
  end 

  
end 
    