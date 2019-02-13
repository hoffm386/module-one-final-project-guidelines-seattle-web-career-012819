# Feed in the arrays of "volumeInfo" hashes and "saleInfo" hashes.
# Create Books out of them!
def create_books(array_of_volume_hashes, array_of_sale_hashes)

  output = [] # Prepare our return data

  # Iterate over our array of "volumeInfo" hashes.
  array_of_volume_hashes.each_with_index do |volume, index|

    # Parse the "listPrice" key's hash value from the "saleInfo" hash for this book.
    list_price_hash = get_key_value( array_of_sale_hashes[index], "listPrice", {} )

    # Parse the "amount" key's numerical value from "list_price_hash".
    # Defaults to a float value of 0.00 if there is no pricing data returned.
    list_price_amount = get_key_value( list_price_hash, "amount", 0.00 )

    # Parse the category info
    # Default to empty array
    get_category_info = get_key_value(volume, "categories", [])

    # Parse the description info
    # Default to empty string
    description_text = get_key_value(volume, "description", "")

    # Create a hash of Book arguments
    book_arguments = {
      title:        get_key_value( volume, "title", "" ),
      publish_date: get_key_value( volume, "publishedDate", "" ),
      page_count:   get_key_value( volume, "pageCount", 0 ),
      price:        list_price_amount,
      genres:       get_category_info.join(" ,"),
      description:  description_text
    }

    # Shovel each new Book into our return data array
    output << Book.create(book_arguments)
  end

  # Return our array of freshly printed books!
  output
end

def create_authors(array_of_volume_hashes)

  output = [] # Prepare our return data

  # Iterate over our array of "volumeInfo" hashes.
  array_of_volume_hashes.each do |volume|

    # Parse the "authors" key's array value from the "volumeInfo" hash.
    authors_array = get_key_value( volume, "authors", [] )

    # Conditionally join multiple authors into one string, separated with " & ", to file them under a unique co-author listing.
    # Otherwise return the only name found as a string.
    # Defaults to returning an empty string if no name is found.
    author_string = (authors_array.length > 1) ? authors_array.join(" & ") : authors_array.join("")

    # Create a hash of Author arguments
    author_arguments = {
      name: author_string
    }

    # Shovel each new Author into our return data array
    output << Author.create(author_arguments)
  end

  # Return our array of Authors!
  output
end

def create_publishers(array_of_volume_hashes)

  output = [] # Prepare our return data

  # Iterate over our array of "volumeInfo" hashes.
  array_of_volume_hashes.each do |volume|

    # Create a hash of publisher arguments
    publisher_arguments = {
      # Parse the "publisher" key's string value from the "volumeInfo" hash
      name: get_key_value( volume, "publisher", "")
    }

    # Shovel each new Publisher into our return data array
    output << Publisher.create(publisher_arguments)
  end

  # Return our list of new Authors!
  output
end

def create_bookdeals(author_array, book_array, publisher_array)

  output = [] # Prepare our return data

  # Iterate over our arrays of seed objects.
  author_array.each_with_index do |author, index|

    # Create a hash of BookDeal arguments.
    bookdeal_arguments = {
      author: author,
      book: book_array[index],
      publisher: publisher_array[index]
    }

    # Shovel each BookDeal into our return data array
    output << BookDeal.create(bookdeal_arguments)
  end

  # Return our swanky array of BookDeals!
  output
end