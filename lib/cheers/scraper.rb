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
      brewery[:name] = name 
      brewery[:address] = address 
      brewery[:index] = index 
      brewery[:url] = "https://www.beeradvocate.com" + brewery_urls[index - 1]
      @@brewery_list << brewery
    end
    # @@brewery_list is returned as an array of hashes [{name: name, address: address, url: url}, {name: na...}]
    @@brewery_list
  end 


  def self.brewery_page(brewery) 
      bp = Nokogiri::HTML(open(brewery.url))
      bp.css("tbody tr").map do |tr|
        # url = tr.css("td a").attribute("href").value
        name = tr.css("td a b").text 
        style = tr.css("td a")[1].text
        tr.css("td span").text == "?" ? abv = tr.css("td span").text : abv = tr.css("td span").text.to_f 
        tr = Hash.new 
        # tr[:url] = url
        tr[:brewery] = brewery
        tr[:name] = name 
        tr[:style] = style
        tr[:abv] = abv
        tr
      end 
  end 

  
end 


    