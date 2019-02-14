# class UserInterface
#     attr_reader :authors, :books, :publishers, :book_deals

#     def initialize(authors, books, publishers, book_deals)
#         @authors = authors
#         @books = books
#         @publishers = publishers
#         @book_deals = book_deals
#     end

#     def menu_text(menu_number)
#       output_array = []

#       strings_to_return = [
#         {
#           heading: "Welcome to Bibs' & Beans' Book Breaker!",
#           prompt: "Please type a number and press ENTER, or type \"exit\" to quit."
#         }
#         "Book Search by Title",
#         "Book Search by Author",
#         "Book Search by Publisher",
#         "Book Search by Genre"
#       ]
#     end

#     def greeting
#       pad = "\n\n"
#       puts "Welcome to Bibs' & Beans' Book Breaker!".prepend(pad) << pad
#     end

#     def cli_input
#         greeting = [
#           "What would you like to do?",
#           "1: Find a book by its title",
#           "2: Find all books by an author",
#           "3: Find all books by publisher",
#           "4: Find books by genre",
#           "6: Play BookRoulette",
#           "10: Bib & Beans' recommendations",
#           "11: I got what I came for, bye guys!"
#       ]
      
#       puts "#{greeting.join("\n")}"
#         input = gets.chomp
#         if input.to_i == 1
#             cli_runner("Please provide the title:", method(:find_book_by_title))
#         elsif input.to_i == 2
#             cli_runner("Please provide all or part of the author\'s name:", method(:books_by_author))
#         elsif input.to_i == 3
#           cli_runner("What is the name of the publisher?", method(:books_by_publisher))
#         elsif input.to_i == 4
#           cli_runner("Please provide a keyword for your genre:", method(:books_by_genre))
#         elsif input.to_i == 6
#           puts "\n"
#           puts "Pick your poison:"
#           puts "\n"
#           book_roulette
#         elsif input.to_i == 10
#             puts "\n"
#             puts "..."
#             sleep(1.second) 
#             puts "We can't read."
#             puts "\n"
#             sleep(1.second) 
#             return cli_input
#         elsif input.to_i == 11
#           cli_end
#         else
#           arr = ["That's not an option!", "Are you crazy?", "Try again I guess", "Not sure about that..."]
#           puts "\n"
#           puts arr.sample
#           puts "\n"
#           return cli_input
#         end
#     end

#     def find_all_book_titles
#         arr = []
#         Book.all.each do |book|
#             arr << book.title
#         end
#         arr
#     end

#     def cli_runner(message, method_to_run)
#         puts message
#         input = gets.chomp.downcase
#         ans = method_to_run.call(input)
#           puts ans
#         return cli_input
#       end

#     def find_book_by_title(str)
#         ans = self.books.select do |book|
#             book.title.downcase.include?(str.downcase)
#         end
#         ans.each do |book|
#             puts "#{book.title}, by #{book.authors[0].name}."
#          end
#          puts "\n"
#     end
    
#     def books_by_author(str)
#         ans = Book.all.select do |book|
#             book.authors[0].name.downcase.include?(str.downcase)
#         end
#         puts "\n"
#         puts "This author has written or collaborated on: "
#             ans.each do |book|
#         puts "#{book.title}, by #{book.authors[0].name}."
#         end
#         puts "\n"
#     end

#     def books_by_publisher(str)
#         ans = Book.all.select do |book|
#             book.publishers[0].name.downcase.include?(str.downcase)
#         end
#         puts "\n"
#         puts "This publisher has released: "
#         ans.each do |book|
#            puts "#{book.title}, by #{book.authors[0].name}."
#         end
#         puts "\n"
#     end

#     def books_by_genre(str)
#         ans = Book.all.select do |book|
#             book.genres.downcase.include?(str.downcase)
#         end
#         puts "\n"
#         puts "Here are the books in your genre selection: "
#             ans.each do |book|
#            puts "#{book.title}, by #{book.authors[0].name}."
#         end
#         puts "\n"
#     end

#     def book_roulette
#         arr = Book.all.sample(3)
#         result = arr.map do |book|
#             arr2 = book.description.split(/ /)
#             new_str = arr2[1..9].join(" ")
#             new_str << "..."
#             new_str.prepend("...")
#         end
#         result.each_with_index do |str, index|
#             puts "#{index+1}#{str}"
#         end
#     end

#     def cli_end
#         puts "\n"
#         puts "Later!"
#         puts "\n"
#       end

# end # of class