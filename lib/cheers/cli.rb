# CLI Controller - responsible for user interactions (ex. welcoming user, dealing with inputs, etc.)

class Cheers::CLI
  
  def call 
    greeting
    options 
  end 
  
  def greeting 
    puts "Hello. This CLI includes information about breweries/bars in Downtown Atlanta as well as the beer they sell."
  end 
  
  def options 
    puts "If you would like to learn more about one of the following options, type its corresponding number and press 'Enter':"
    puts <<-DOC 
      1. Breweries
      2. Bars 
      3. Beer 
    DOC
  end 
  
end 