# # These are the find_by methods that perform as expected.

# class UserInterface
#     attr_reader :authors, :books, :publishers
#     @@counter = 0

#     def initialize(authors, books, publishers)
#         @authors = authors
#         @books = books
#         @publishers = publishers
#     end

#     def find_books_by_title(book_title)
#       self.books.select { |b|
#         b.title.downcase.include?( book_title.downcase )
#       }
#     end

#     def find_books_by_author(author_name)
#       self.authors.select { |a|
#         a.name.downcase.include?( author_name.downcase )
#       }.map { |m|
#         m.books
#       }.flatten.uniq
#     end

#     def find_books_by_publisher(publisher_name)
#       self.publishers.select { |p|
#         p.name.downcase.include?( publisher_name.downcase )
#       }.map { |m|
#         m.books
#       }.flatten.uniq
#     end

#     def find_books_by_publish_date(book_date)
#       self.books.select { |b|
#         b.publish_date.downcase.include?( book_date.downcase )
#       }.uniq
#     end

#     def find_books_by_page_count(book_pages)
#       self.books.select { |b|
#         b.page_count == book_pages
#       }.uniq
#     end

#     def find_books_by_price(book_price)
#       self.books.select { |b|
#         b.price == book_price
#       }.uniq
#     end

#     def find_books_by_genre(book_genre)
#       self.books.select { |b|
#         b.genres.downcase.include?(book_genre.downcase)
#       }.uniq
#     end

#     def find_books_by_keyword(book_keyword)
#       self.books.select { |b|
#         b.description.downcase.include?( book_keyword.downcase )
#       }.uniq
#     end

    


#     def cli_end
#         puts "\n"
#         puts "Later!"
#         puts "\n"
#       end

# end # of class
