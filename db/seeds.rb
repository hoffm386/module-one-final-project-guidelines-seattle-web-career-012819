require 'rest-client'
require 'json'
require 'pry'

def get_api_data
  response_string = RestClient.get("https://jobs.github.com/positions.json")
  response_hash = JSON.parse(response_string)
end

def iterate_api_data
  get_api_data.each do |job|
  end
end

puts "populating job postings"
  get_api_data.each do |job|
    JobPosting.create(:title = job["title"])
  end
