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
    self.api_hash_data.each do |api|
      #if api.include?(["creator"])
      if api["creator"] != nil
        creator_array << api["creator"]
      end
        #Creator.new(name: api["creator"])
      #end
    end
   creator_array
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
