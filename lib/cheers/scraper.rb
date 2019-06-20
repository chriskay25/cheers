class Cheers::Scraper

  @@brewery_list = []

  def self.breweries 
    # Uses the page method to get HTML, grabs content from first ul, then selects the text from the li's and split it to return an
    # array of arrays, formatted [["Brewery Name", "Brewery Address"], ["Brewery Name", "Brewery Address"]]
    home_pg = Nokogiri::HTML(open("https://www.beeradvocate.com/place/city/1/"))
    home_pg.css("div#ba-content ul").first.css("li").map {|li| li.text}.map {|brewery| brewery.split("  - ")}.each.with_index(1) do |brewery, index|
      name = brewery[0]
      address = brewery[1] 
      brewery = Hash.new
      brewery[:name] = name 
      brewery[:address] = address 
      brewery[:index] = index 
      brewery[:url] = "https://www.beeradvocate.com" + home_pg.css("div#ba-content ul").first.css("li a").attribute("href").value
      @@brewery_list << brewery
    end
    # @@brewery_list is returned as an array of hashes [{name: name, address: address, url: url}, {name: na...}]
    @@brewery_list
  end 


  def self.brewery_page 
    @@brewery_list.map do |brewery| 
      bp = Nokogiri::HTML(open(brewery[:url]))
      beer_count = bp.css("div#stats_box dd").children[0].text
      # beer_list = bp.css("tbody a").map {|a| a.children.text}
      # beer_list.each.with_index(1) do |beer, index|
      #   index.odd? ? name = beer : type = beer 
      # beer_list = bp.css("tbody a").map {|a| a.attribute("href").value}
      bp.css("tbody tr td").map.with_index(1) do |td, index| 
        index.odd? ? "#{td} a" : nil 
      end 
    end 
  end 

  
end 


    