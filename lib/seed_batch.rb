def generate_seeds_from_search_term(search_term)

  # Get the query from the API
  # TODO: where is this method?
  json_data = get_data(search_term)

  # Parse the "items" array from the API data
  # TODO: where is this method?
  json_items = parse_items(json_data)

  # Parse the "volumeInfo" hash from the "items" array
  # TODO: where is this method?
  json_volumes = parse_volumes(json_items)

  # Parse the "saleInfo" hash from the "items" array
  # TODO: where is this method?
  json_sales = parse_sales(json_items)

  ### From Here, we can collect all necessary data ###
  ### for each class type. ###
  # TODO: where is this method?
  book_seeds = create_books(json_volumes, json_sales)
  # TODO: where is this method?
  author_seeds = create_authors(json_volumes)
  # TODO: where is this method?
  publisher_seeds = create_publishers(json_volumes)
  # TODO: where is this method?
  bookdeal_seeds = create_bookdeals(author_seeds, book_seeds, publisher_seeds)
end
