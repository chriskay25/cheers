class Cheers::Scraper
  
  def breweries_page 
    breweries_page = Nokogiri::HTML(open("https://www.beeradvocate.com/place/city/1/"))
    breweries_page.css("div#ba-content ul li[1] a")
  end 
  
end 
    