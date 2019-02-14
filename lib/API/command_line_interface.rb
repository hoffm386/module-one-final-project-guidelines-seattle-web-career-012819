class Command_line_interface

  # Introduction to the Guessing Game
  def welcome
    puts "********* Welcome to the Library Trivia Game *********"
    puts "(Please choose the correct answers for each questions)"
  end

  # Method to get back the user's answer in each question
  def user_answer
    puts "Choose the correct answer (a, b or c): "
    gets.chomp
  end

  # Question 1
  def question_01
    puts "1. Which author has written the most books?"
    print ""
    answer = gets.chomp
  end

  # Question 2
  def books_by_author

    #set the author the question will search for
    author_name = "Gloria Steinem"

    # find the book written by author_name
    author = Creator.find_by name: author_name
    book_by_author = author.books.map {|book| "#{book.name}"}

    # question
    puts "2. Which book did #{author_name} write?"
    # answer options (c is correct):
    puts "  a. All for You"
    puts "  b. Avian"
    puts "  c. #{book_by_author[0]}"


    user_guess = self.user_answer

    # check user's answer
    if user_guess == "c" || user_guess == "C"
      puts "Great job! #{author_name} did write #{book_by_author[0]}!"
    else
      puts "Incorrect. Try again."
      self.books_by_author
    end

  end


    # user_guess = gets.chomp




  # User provides a publisher name,
  # Then a list of all of their book titles and authors (creator) is returned
  def books_by_publisher
    print "Enter a publisher name: "
    publisher_name = gets.chomp
    publisher = Publisher.find_by name: publisher_name
    puts publisher.books.map {|book| "#{book.name} | #{book.creator.name}"}
  end

end #end of class
