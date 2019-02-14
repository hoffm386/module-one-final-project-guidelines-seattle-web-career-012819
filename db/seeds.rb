Book.destroy_all
Creator.destroy_all
Publisher.destroy_all

#adds authors names to database
api_names = API_Hash.new
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
  Book.create(
    title: book
  )
end
