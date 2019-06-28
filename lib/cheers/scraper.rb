class Cheers::Scraper

  @@brewery_list = []

  def self.breweries 
    # Uses the page method to get HTML, grabs content from first ul, then selects the text from the li's and split it to return an
    # array of arrays, formatted [["Brewery Name", "Brewery Address"], ["Brewery Name", "Brewery Address"]]
    home_pg = Nokogiri::HTML(open("https://www.beeradvocate.com/place/city/1/"))
    brewery_urls = home_pg.css("div#ba-content ul").first.css("li a").map {|a| a.attribute("href").value}
    home_pg.css("div#ba-content ul").first.css("li").map {|li| li.text}.map {|brewery| brewery.split("  - ")}.each.with_index(1) do |brewery, index|
      name = brewery[0]
      address = brewery[1] 
      brewery = Hash.new
      brewery = {name: name, address: address, index: index, url: ("https://www.beeradvocate.com" + brewery_urls[index - 1])} 
      @@brewery_list << brewery
    end
    @@brewery_list
  end 


  def self.brewery_page(brewery) 
      bp = Nokogiri::HTML(open(brewery.url))
      bp.css("tbody tr").map do |tr|
        name = tr.css("td a b").text 
        style = tr.css("td a")[1].text
        rating = tr.css("td b").last.text
        tr.css("td span").text == "?" ? abv = tr.css("td span").text : abv = tr.css("td span").text.to_f 
        tr = Hash.new 
        tr = {brewery: brewery, name: name, style: style, rating: rating, abv: abv}
      end 
  end 

end 


    