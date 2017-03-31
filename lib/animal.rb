require "pry"
require "nokogiri"
require "open-uri"

class Animal
  
  def initialize (animal_page)
    @animal_page = open(animal_page)
    
  end

  def get_page
    Nokogiri::HTML(@animal_page)    
  end

  def get_animal
    self.get_page.css(".infobox")
  end

  def get_taxonomy
    taxonomy_hash = {}    
    taxonomy = self.get_animal.css("tr").text
    taxonomy.gsub("\n", " ").scan(/Kingdom.*/).join.split("  ").each do |item, i| 
      taxonomy_hash[item.split(" ")[0]] = item.split(" ")[1]
      break if  item.split(" ")[0] == "Species:"
    end

      taxonomy_hash
  end
  
end

#some animals
animals = ["dog",
           "cow",
           "pig",
           "rat",
           "mouse",
           "monkey",
           "lizard",
           "elephant",
           "tiger",
           "lion",
           "giraffe",
           "snake",
           "wolf",
           "donkey",
           "buffalo",
           "dove"]

#Iteration through wikipedia animal pages

animals.each do |item| 
  animal = Animal.new("https://en.wikipedia.org/wiki/#{item}")
  
 
  puts item
  animal.get_taxonomy.each {|key, value| puts "    #{key} #{value}"}
  50.times do
    print "-"
  end
  print "\n"
  
  
end
