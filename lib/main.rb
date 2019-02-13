def main
  # this will be our point of entry
  # greeting = [
    puts "Welcome to Bib & Beans' Book Breaker!"
  # puts "#{greeting.join("\n")}"

  def cli_input
    greeting = ["What would you like to do?",
      "1: Find a book by its title",
      "2: Find all books by an author",
      "3: Find all books by publisher",
      "4: Find books by genre",
      "6: Play BookRoulette",
      "11. I got what I came for, bye Bib & Beans!"
  ]
  puts "#{greeting.join("\n")}"
    input = gets.chomp
    if input.to_i == 1
      cli_books_by_title
    elsif input.to_i == 2
      cli_books_by_author
    elsif input.to_i == 3
      cli_books_by_publisher
    elsif input.to_i == 4
      cli_books_by_genre
    elsif input.to_i == 6
      cli_book_roulette
    elsif input.to_i == 11
      cli_end
    elsif
      puts "That's not an option!"
      cli_input
    end

  end

  def cli_books_by_title
      puts "Please provide the title:"
      input2 = gets.chomp.downcase
      ans = find_book_by_title(input2.to_s)
        puts ans
      return cli_input
  end

  def cli_books_by_author
    puts "Please provide all or part of the author\'s name:"
    input = gets.chomp.downcase
    ans = books_by_author(input)
      puts ans
    return cli_input
  end

  def cli_books_by_publisher
    puts "What is the name of the publisher?"
    input = gets.chomp.downcase
    ans = books_by_publisher(input)
    puts ans
    return cli_input
  end

  def cli_books_by_genre
    puts "Please provide a keyword for your genre:"
    input = gets.chomp.downcase
    ans = books_by_genre(input)
      puts ans
    return cli_input
  end

  def cli_book_roulette
    "Pick Your Poison:"

  end

  def cli_end
    puts "Later!"
  end

  cli_input
  # binding.pry
end