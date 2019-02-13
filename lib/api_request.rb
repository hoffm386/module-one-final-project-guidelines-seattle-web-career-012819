# Return the API url with our search term in uri encoded format
def get_api_url(search_term)
  "https://www.googleapis.com/books/v1/volumes?q=#{URI::encode(search_term)}"
end

# Return data from the API in JSON format.
def get_data(search_term)
  request_url = get_api_url(search_term)
  raw_data = RestClient.get(request_url)
  json_data = JSON.parse(raw_data.body)
end