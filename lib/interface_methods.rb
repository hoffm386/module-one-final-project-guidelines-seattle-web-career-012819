# These are the find_by methods that perform as expected.

class UserInterface
    attr_reader :authors, :books, :publishers
    @@counter = 0

    def initialize(authors, books, publishers)
        @authors = authors
        @books = books
        @publishers = publishers
    end

    def find_books_by_title(book_title)
      self.books.select { |b|
        b.title.downcase.include?( book_title.downcase )
      }
    end

    def find_books_by_author(author_name)
      self.authors.select { |a|
        a.name.downcase.include?( author_name.downcase )
      }.map { |m|
        m.books
      }.flatten.uniq
    end

    def find_books_by_publisher(publisher_name)
      self.publishers.select { |p|
        p.name.downcase.include?( publisher_name.downcase )
      }.map { |m|
        m.books
      }.flatten.uniq
    end

    def find_books_by_publish_date(book_date)
      self.books.select { |b|
        b.publish_date.downcase.include?( book_date.downcase )
      }.uniq
    end

    def find_books_by_page_count(book_pages)
      self.books.select { |b|
        b.page_count == book_pages
      }.uniq
    end

    def find_books_by_price(book_price)
      self.books.select { |b|
        b.price == book_price
      }.uniq
    end

    def find_books_by_genre(book_genre)
      self.books.select { |b|
        b.genres.downcase.include?(book_genre.downcase)
      }.uniq
    end

    def find_books_by_keyword(book_keyword)
      self.books.select { |b|
        b.description.downcase.include?( book_keyword.downcase )
      }.uniq
    end
end
    def books_by_genre(str)
        ans = Book.all.select do |book|
            book.genres.downcase.include?(str.downcase) || book.title.downcase.include?(str.downcase)
        end
        puts "\n"
        if ans.empty? 
            pick = ["biography", "cat", "dog", "sports", "humor"]
            puts "Sorry, nothing for that. Perhaps try #{pick.sample}?"
        else
        puts "Here are the books in your genre selection: "
            ans.each do |book|
           puts "#{book.title}, by #{book.authors[0].name}."
        end
    end
        puts "\n"
    end

    def book_price(str)
        arr = []
        Book.all.each do |book|
            if book.title.downcase == str.to_s.downcase
                arr << book.price
            end
        end
        if arr[0] > 0
            arr2 = ["Worth it.", "Why not?", "Let's do this!", "It WOULD look good on your bookshelf...", "Can't put a price on a good read, though."]
            puts "\n"
            puts "That one is $#{arr[0]}. #{arr2.sample}"
        else 
            puts "That one isn't for sale right now. We do NOT recommending finding a link to illegaly download it instead."
        end
    end

    def book_grab_bag
          puts "\n"
          puts "Pick your poison:"
          puts "\n"
        arr = Book.all.sample(3)
        result = arr.map do |book|
            arr2 = book.description.split(/ /)
            new_str = arr2[1..9].join(" ")
            new_str << "..."
            new_str.prepend("...")
        end
        result.each_with_index do |str, index|
            puts "#{index+1}#{str}"
        end
        input = gets.chomp
        puts "\n"
        puts "You've chosen #{arr[input.to_i - 1].title}, by #{arr[input.to_i - 1].authors[0].name}. Happy reading!"
        puts "\n"
        sleep(1.second)
        return cli_input
    end

    def cheapo
        puts "Calculating prices.."
        2.times do 
            sleep(1) 
            puts"."
        end
        cheapest = nil
        Book.all.each do |book|
            if cheapest == nil
                cheapest = book
            elsif book.price > 0 && book.price < cheapest.price
                cheapest = book
            end
        end
        puts "The cheapest book is #{cheapest.title} by #{cheapest.authors[0].name}, at $#{cheapest.price}. That's basically free!"
        puts "\n"
        return cli_input
    end

    def bib_n_bean
        if @@counter == 0
            puts "\n"
            puts "..."
            sleep(1.second) 
            puts "We can't read."
            puts "\n"
            sleep(1.second) 
            @@counter += 1
        elsif 
            @@counter == 1
            puts "Alright, fine. Bib likes #{random_cat_book}!"
            puts "\n"
            sleep(1.second) 
            @@counter += 1
        elsif
            @@counter == 2
            puts "Beans says you should read #{random_dog_book}!"
            puts "\n"
            sleep(1.second) 
            @@counter = 0
        end
    end

    def random_cat_book
        arr =[]
        Book.all.each do |book|
            if book.genres.downcase.include?("cat") || book.title.downcase.include?("cat")
                arr << book
            end
        end
        boo = arr.sample
        "#{boo.title}, by #{boo.authors[0].name}"
    end

    def random_dog_book
        arr =[]
        Book.all.each do |book|
            if book.genres.downcase.include?("dog") || book.title.downcase.include?("dog")
                arr << book
            end
        end
        boo = arr.sample
        "#{boo.title}, by #{boo.authors[0].name}"
    end


    def cli_end
        puts "\n"
        puts "Later!"
        puts "\n"
      end

end # of class
