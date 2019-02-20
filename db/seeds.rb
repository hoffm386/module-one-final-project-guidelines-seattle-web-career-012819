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

# JobHunter.destroy_all
JobPosting.destroy_all
Company.destroy_all
Branch.destroy_all

puts "populating companies"
  get_api_data.each do |job|
    Company.find_or_create_by(
      name: job["company"],
      description: job["description"],
      company_url: job["company_url"]
    )
  end

puts "populating branches"
  get_api_data.each do |job|
    Branch.find_or_create_by(
      name: job["company"],
      company: Company.where(name: job["company"]).first,
      location: job["location"]
    )
  end

  puts "populating job postings"
    get_api_data.each do |job|
      JobPosting.find_or_create_by(
        title: job["title"],
        description: job["description"],
        employment_type: job["type"],
        application_link: job["how_to_apply"],
        branch: Branch.where(name: job["company"]).first
      )
    end
