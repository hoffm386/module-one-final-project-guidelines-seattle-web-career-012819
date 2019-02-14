class Command_line_interface

  @stars = 0


  # Introduction to the Guessing Game
  def welcome
    puts "********* Welcome to the Library Trivia Game *********"
    puts "(Please choose the correct answers for each questions)"
  end

=
  def test
    author_name = []
    Creator.all.each do |author|
      author_name << author.name
    end
    puts author_name.sample
  end

=
  # Method to get back the user's answer in each question
  def user_answer
    puts "Choose the correct answer (a, b or c): "
    gets.chomp
  end

  # Question 1

  def question_01
    choice01 = "David Baldacci"
    puts "1. Which author has written the most books?"
    puts
    puts "    a. #{choice01}.  b. Emma Healey.  c.Garry Disher"
    puts
    print "Please select an answer: "
    answer = gets.chomp
    most_authors = nil
    book_count =0
    Creator.all.each do |creator|
      if creator.books.count > book_count
        book_count = creator.books.count
        most_authors = creator.name
      end
    end
    if answer == "a" || answer == "A"
      puts "*************************************************************"
      puts "*************************************************************"
      puts
      puts "*****Correct!! Congratulations******"
      puts "*****#{most_authors} has written #{book_count} books******"
    else
      puts "Incorrect, please try again"
      puts "*************************************************************"
      puts "*************************************************************"
      puts
      puts
      self.question_01
    end
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
    print "3. Which publisher has most authors?"
    puts "   a.- ,  b"
    #publisher_name = gets.chomp
    # publisher = Publisher.find_by name: publisher_name
    # puts publisher.books.map {|book| "#{book.name} | #{book.creator.name}"}
    author_count =0
    publisher_name = nil
    Publisher.all.each do |publisher|
      if publisher.creators.count > author_count
        author_count = publisher.creators.count
        publisher_name = publisher.name
      end
    end
    puts "#{author_count} and #{publisher_name}"

  end

end #end of class
