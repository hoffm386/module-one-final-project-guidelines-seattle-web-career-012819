#for fun!
class UserInterface
    attr_reader :authors, :books, :publishers, :book_deals

    def initialize(authors, books, publishers, book_deals)
        @authors = authors
        @books = books
        @publishers = publishers
        @book_deals = book_deals
    end

    # A string to search for, a symbol for the dataset to look in,
    # and an attribute of the items in that dataset to look in.

    #self.search("Allen", "authors", "name") # by author
    #self.search("Hal", "publishers", "name") # by publisher
    #self.search("Hal", "publishers", "name", "books") # return the books

    # def self.search(search_term, class_name, attrib_to_check, attrib_to_return=nil)
    #     return_array = []
    #     self[class_name].each do |class_instance|
    #         if class_instance[attrib_to_check].class == Array
    #             class_instance[attrib_to_check].each do |attrib_we_checked|
    #                 if attrib_we_checked.to_s.downcase.include?(search_term.to_s.downcase)
    #                     value_to_shovel = attrib_we_checked
    #                     if attrib_to_return 
    #                         value_to_shovel = class_instance[attrib_to_return]
    #                     end
    #                     return_array << value_to_shovel
    #                 end
    #             end
    #         else
    #             if class_instance[attrib].to_s.downcase.include?(search_term.to_s.downcase)
    #                 return_array << class_instance[attrib]
    #             end
    #         end
    #     end
    #     return_array
    # end
    def results(ans)
        ans.each do |book|
            puts "#{book.title}, by #{book.authors[0].name}."
         end
         puts "\n"
         ans
    end

    def find_book_by_title(str)
        ans = self.books.select do |book|
            book.title.downcase.include?(str.downcase)
        end
        results(ans)
    end

    # def self.find_books_by_author(author_to_find)
    #     self.search(author_to_find, "authors", "name")
    # end

    # def self.find_books_by_publisher(publisher_to_find)
    #     self.search(publisher_to_find, "publishers", "name", "books")
    # end
end

menu = UserInterface.new(Author.all, Book.all, Publisher.all, BookDeal.all)
binding.pry
# class Interface

# generic find, what to look for, what attribute to find, where to find it.

def find_all_book_titles
    arr = []
    Book.all.each do |book|
        arr << book.title
    end
    arr
end

# def find_book_by_title(str)
#     ans = Book.all.select do |book|
#         book.title.downcase == str.downcase
#     end
#     if ans.empty?
#         "That's not a book, bro."
#     else
#     "Your book is #{ans[0].title}, by #{ans[0].authors[0].name}."
#     end
#     puts "\n"
#     ans
# end

# def books_by_author(str)
#     ans = Book.all.select do |book|
#         book.authors[0].name.downcase.include?(str.downcase)
#     end
#     puts "This author has written or collaborated on: "
#         ans.each do |book|
#        puts "#{book.title}, by #{book.authors[0].name}."
#     end
#     puts "\n"
#     ans
# end

def books_by_publisher(str)
    ans = Book.all.select do |book|
        book.publishers[0].name.downcase.include?(str.downcase)
    end
    puts "This publisher has released: "
    ans.each do |book|
       puts "#{book.title}, by #{book.authors[0].name}."
    end
    puts "\n"
    ans
end

def books_by_genre(str)
    ans = Book.all.select do |book|
        book.genres.downcase.include?(str.downcase)
    end
    puts "Here are the books in your genre selection: "
        ans.each do |book|
       puts "#{book.title}, by #{book.authors[0].name}."
    end
    puts "\n"
    ans
end

def book_roulette
    arr = Book.all.sample(3)
    arr.map do |book|
        arr2 = book.description.split(/ /)
        new_str = arr2[1..9].join(" ")
        new_str << "..."
        new_str.prepend("...")
    end
end



# end # of class

