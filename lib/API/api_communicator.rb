require 'rest-client'
require 'json'
require 'pry'
class API_Hash

  def api_hash_data
    response_string = RestClient.get('https://data.seattle.gov/resource/tmmm-ytt6.json')
    response_hash = JSON.parse(response_string)
    # response_hash.each_with_index do |print, index|
    #   puts "#{index}: #{print}"
    # end
  end

  def add_creator_names
    creator_array =[]
    value_count =0
    creator_hash = Hash.new(0)
    self.api_hash_data.each do |api|
      #if api.include?(["creator"])
      if api["creator"] != nil
        # creator_array << api["creator"]
        creator_hash[api["creator"]] += 1
      end
        #Creator.new(name: api["creator"])
      #end
    end
   #puts creator_hash.values.sort
   k = creator_hash.each do |k, v|
     if v > value_count
       value_count = v
       puts k
     end
   end
   puts value_count
  end

  def add_publisher_names
    creator_array =[]
    self.api_hash_data.each do |api|
      if api["publisher"] != nil
        creator_array << api["publisher"]
      end
    end
    creator_array
  end
end#end of class
