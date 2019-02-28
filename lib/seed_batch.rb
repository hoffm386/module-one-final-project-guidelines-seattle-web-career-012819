class SeedBatch

  attr_reader :search_term

  def initialize(search_term)
    @search_term = search_term
  end

  def generate_seeds_from_search_term

    # Get the query from the API
    api_request = ApiRequest.new(search_term)
    json_data = api_request.get_data

    # Parse the "items" array from the API data
    json_items = ApiIterator.parse_items(json_data)
    # Parse the "volumeInfo" hash from the "items" array
    json_volumes = ApiIterator.parse_volumes(json_items)
    # Parse the "saleInfo" hash from the "items" array
    json_sales = ApiIterator.parse_sales(json_items)

    ### From Here, we can collect all necessary data ###
    ### for each class type. ###
    instance_creator = InstanceCreator.new(json_volumes, json_sales)
    book_seeds = instance_creator.create_books
    author_seeds = instance_creator.create_authors
    publisher_seeds = instance_creator.create_publishers
    bookdeal_seeds = instance_creator.create_bookdeals(author_seeds, book_seeds, publisher_seeds)
  end

end
