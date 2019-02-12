require 'rest-client'
require 'json'
require 'pry'

def data
  response_string = RestClient.get('https://data.seattle.gov/resource/tmmm-ytt6.json')
  response_hash = JSON.parse(response_string)

  response_hash.each_with_index do |t, index|
    puts "#{index}: #{t}"
  end
end
