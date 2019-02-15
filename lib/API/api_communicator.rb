require 'rest-client'
require 'json'
require 'pry'
class API_Hash
  # returning the whole book checkouts dataset from API
  def api_hash_data
    response_string = RestClient.get('https://data.seattle.gov/resource/tmmm-ytt6.json')
    response_hash = JSON.parse(response_string)
  end

  #this method adds name column to the creator class on seeds.rb
  def add_creator_names
    creator_array =[]
    self.api_hash_data.each do |api|
      if api["creator"] == nil
         creator_array << "Unknown Authors"
       else
         # TODO: Ellen add handling for birth/death years
         # TODO: Ellen add handling for trailing commas
         last_char = publisher_name[-1]
         creator_array << api["creator"]
      end
    end
    creator_array.uniq
  end

  #this method adds name column to the publisher class when seed.rb runs
  def add_publisher_names
    publisher_array =[]
    self.api_hash_data.each do |api|
      if api["publisher"] == nil
        publisher_array << "Unknown Publisher"
      else
        publisher_name = api["publisher"]
        # remove unnecessary trailing comma or semicolon from publisher_name
        last_char = publisher_name[-1]
        if last_char == "," || last_char == ";"
          publisher_name = publisher_name[0..-2]
        end
        publisher_array << publisher_name
      end
    end
    publisher_array.uniq
  end

  #this method adds title column to the book class when seed.rb runs
  def add_book_title
    book_title_array = []

    self.api_hash_data.each do |api|
      book_hash = {}
      # if the name has a "/" in it, remove "/" and what follows
      book_title = api["title"].split("/").first.strip
      book_hash["title"] = book_title

      book_hash["creator_name"] = api["creator"]
      book_hash["publisher_name"] = api["publisher"]
      book_hash["usage_class"] = api["usageclass"]
      book_title_array << book_hash
    end
    book_title_array
  end


end #end of class
