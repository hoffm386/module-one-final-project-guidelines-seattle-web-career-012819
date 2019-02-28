class InstanceCreator

  attr_reader :array_of_volume_hashes, :array_of_sale_hashes

  def initialize(json_volumes, json_sales)
    @array_of_volume_hashes = json_volumes
    @array_of_sale_hashes = json_sales
  end

  def create_books

    output = [] # Prepare our return data

    # iterate over the array of "volumeInfo" hashes and array of "saleInfo" hashes
    array_of_volume_hashes.zip(array_of_sale_hashes).each do |volume, sale|

      # Parse the "amount" key's numerical value from "listPrice" hash in sale
      # Defaults to a float value of 0.00 if there is no pricing data returned.
      price = sale.dig("listPrice", "amount") ? sale["listPrice"]["amount"] : 0.00

      # Create a hash of Book arguments
      book_arguments = {
        title:        ApiIterator.get_key_value( volume, "title", "" ),
        publish_date: ApiIterator.get_key_value( volume, "publishedDate", "" ),
        page_count:   ApiIterator.get_key_value( volume, "pageCount", 0 ),
        price:        price,
        genres:       ApiIterator.get_key_value( volume, "categories", [] ).join("; "),
        description:  ApiIterator.get_key_value( volume, "description", "" ),
        maturity:     ApiIterator.get_key_value( volume, "maturityRating", "")
      }

      # Shovel each new Book into our return data array
      output << Book.create(book_arguments)
    end

    # Return our array of freshly printed books!
    output
  end

  def create_authors

    output = [] # Prepare our return data

    # Iterate over our array of "volumeInfo" hashes.
    array_of_volume_hashes.each do |volume|

      # Parse the "authors" key's array value from the "volumeInfo" hash.
      authors_array = ApiIterator.get_key_value( volume, "authors", [] )

      # Conditionally join multiple authors into one string, separated with " & ", to file them under a unique co-author listing.
      author_string = if authors_array.length > 1
        authors_array.join(" & ")
      # Otherwise return the only name found as a string.
      elsif authors_array.length == 1
        authors_array.first
      # Defaults to returning an empty string if no name is found.
      else
        ""
      end

      # Create a hash of Author arguments
      author_arguments = {
        name: author_string
      }

      # Shovel each new Author into our return data array
      output << Author.find_or_create_by(author_arguments)
    end

    # Return our array of Authors!
    output
  end

  def create_publishers

    output = [] # Prepare our return data

    # Iterate over our array of "volumeInfo" hashes.
    array_of_volume_hashes.each do |volume|

      # Create a hash of publisher arguments
      publisher_arguments = {
        # Parse the "publisher" key's string value from the "volumeInfo" hash
        name: ApiIterator.get_key_value( volume, "publisher", "")
      }

      # Shovel each new Publisher into our return data array
      output << Publisher.find_or_create_by(publisher_arguments)
    end

    # Return our list of new Publishers!
    output
  end

  def create_bookdeals(author_array, book_array, publisher_array)

    output = [] # Prepare our return data

    # Iterate over our arrays of seed objects.
    author_array.zip(book_array, publisher_array).each do |author, book, publisher|

      # Create a hash of BookDeal arguments.
      bookdeal_arguments = {
        author: author,
        book: book,
        publisher: publisher
      }

      # Shovel each BookDeal into our return data array
      output << BookDeal.create(bookdeal_arguments)
    end

    # Return our swanky array of BookDeals!
    output
  end
end
