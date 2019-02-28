class ApiRequest

  attr_reader :search_term

  def initialize(search_term)
    @search_term = search_term
  end

  # Return the API url with our search term in uri encoded format
  def get_api_url
    "https://www.googleapis.com/books/v1/volumes?q=#{URI::encode(search_term)}"
  end

  # Return data from the API in JSON format.
  def get_data
    request_url = get_api_url
    raw_data = RestClient.get(request_url)
    json_data = JSON.parse(raw_data.body)
  end

end
