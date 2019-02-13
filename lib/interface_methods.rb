#for fun!
# class Interface

def find_all_book_titles
    arr = []
    Book.all.each do |book|
        arr << book.title
    end
    arr
end

def find_book_by_title(str)
    ans = Book.all.select do |book|
        book.title.downcase == str.downcase
    end
    if ans.empty?
        "That's not a book, bro."
    else
    "Your book is #{ans[0].title}, by #{ans[0].authors[0].name}."
    end
    puts "\n"
    ans
end

def books_by_author(str)
    ans = Book.all.select do |book|
        book.authors[0].name.downcase.include?(str.downcase)
    end
    puts "This author has written or collaborated on: "
        ans.each do |book|
       puts "#{book.title}, by #{book.authors[0].name}."
    end
    puts "\n"
    ans
end

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

