Book.destroy_all
Author.destroy_all
Publisher.destroy_all

def data_retrieved
  response = RestClient.get("https://www.googleapis.com/books/v1/volumes?q=allen")
  usable = JSON.parse(response.body)
  usable
end

# AUTHOR SEEDS

authors = []

data_retrieved["items"].each do |item|
  item.each do |item_key, item_val|
    if item_key=="volumeInfo"
      item_val.each do |volume_key, volume_val|
        if volume_key=="authors"
          volume_val.each do |author|
            authors << author
          end
        end
      end
    end
  end
end

authors.uniq.each do |author|
  Author.create(name: author)
end

# BOOK SEEDS

books = []

# Iterate over the data we have retrieved.
data_retrieved["items"].each do |item|
  # For each item in the array nested into the key "items"...
  item.each do |item_key, item_val|
    # Create a blank hash for our arguments.
    book_details = {}
    # If we are inside of the key "volumeInfo"...
    if item_key=="volumeInfo"
      # If a "title" key esists and we have not collected it yet...
      if !!item_val["title"] && book_details[:title]==nil
        # Collect it as an argument.
        book_details[:title] = item_val["title"]
      end

      # If a "publishDate" key exists and we have not collected it yet...
      if !!item_val["publishedDate"] && book_details[:publish_date]==nil
        # Collect it as an argument.
        book_details[:publish_date] = item_val["publishedDate"]
      end

      # If a "pageCount" key exists and we have not collected it yet...
      if !!item_val["pageCount"] && book_details[:page_count]==nil
        # Collect it as an argument.
        book_details[:page_count] = item_val["pageCount"]
      end
    # If we are inside of the key "saleInfo"...
    elsif item_key=="saleInfo"
      # If a "listPrice" key exists...
      if !!item_val["listPrice"]
        # Iterate over its nested price data.
        item_val["listPrice"].each do |price_key, price_val|
        # If we have found the "amount" key...
          if price_key=="amount"
            # If we have not yet collected a price...
            if book_details[:price]==nil
              # Collect "amount" as an argument.
              book_details[:price] = price_val
            end
          end
        end
      end
    end
    Book.create(book_details)
  end
end