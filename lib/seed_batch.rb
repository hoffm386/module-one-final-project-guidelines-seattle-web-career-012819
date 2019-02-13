def generate_seeds_from_search_term(search_term)

  # Get the query from the API
  json_data = get_data(search_term)

  # Parse the "items" array from the API data
  json_items = parse_items(json_data)

  # Parse the "volumeInfo" hash from the "items" array
  json_volumes = parse_volumes(json_items)

  # Parse the "saleInfo" hash from the "items" array
  json_sales = parse_sales(json_items)

  ### From Here, we can collect all necessary data ###
  ### for each class type. ###
  book_seeds = create_books(json_volumes, json_sales)
  author_seeds = create_authors(json_volumes)
  publisher_seeds = create_publishers(json_volumes)
  bookdeal_seeds = create_bookdeals(author_seeds, book_seeds, publisher_seeds)
end