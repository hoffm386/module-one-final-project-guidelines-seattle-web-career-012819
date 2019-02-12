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

JobPosting.destroy_all
Company.destroy_all
Branch.destroy_all

puts "populating job postings"
  get_api_data.each do |job|
    JobPosting.create(
      title: job["title"],
      description: job["description"],
      employment_type: job["type"],
      application_link: job["how_to_apply"]
    )
  end

puts "populating branches"
  get_api_data.each do |job|
    Branch.create(
      company: job["company"],
      location: job["location"]
    )
  end
