Book.destroy_all
Creator.destroy_all
Publisher.destroy_all

api_names = API_Hash.new
#adds authors names to database
author_name_array = api_names.add_creator_names
author_name_array.each do |author|
  Creator.create(
    name: author
  )
end

#adds publisher's names to database
publisher_name_array = api_names.add_publisher_names
publisher_name_array.each do |publisher|
  Publisher.create(
    name: publisher
  )
end

#adds book information (title, ect) to database
book_array = api_names.add_book_title
book_array.each do |book|
  creator = Creator.find_by ({"name" => book["creator_name"]})
  publisher = Publisher.find_by ({"name" => book["publisher_name"]})
  # only create book object if creator and publisher are in the database
  if creator && publisher
    Book.create(
      name: book["title"],
      usage_class: book["usage_class"],
      creator: creator,
      publisher: publisher
    )
  end
end
