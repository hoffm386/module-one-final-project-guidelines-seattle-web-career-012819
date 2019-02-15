class Command_line_interface
  @@stars = 0
  # Introduction to the Guessing Game
  def welcome
    puts "********* Welcome to the Library Trivia Game *********"
    puts "(Please choose the correct answers for each questions)"
  end

  # Method to get back the user's answer in each question
  def user_answer
    puts
    puts "Choose the correct answer (a, b or c): "
    print "Your Answer:"
    gets.chomp
  end

  # Question 1: Which author has written the most books?
  def author_most_book
    choice01 = "David Baldacci"
    puts "1. Which author has written the most books?"
    puts
    puts "a. #{choice01}"
    puts "b. Emma Healey"
    puts "c.Garry Disher"
    answer = self.user_answer
    most_authors = nil
    book_count =0
    Creator.all.each do |creator|
      if creator.books.count > book_count
        book_count = creator.books.count
        most_authors = creator.name
      end
    end
    if answer == "a" || answer == "A"
      puts `clear`
      puts
      puts "Correct!! #{most_authors} has written #{book_count} books"
      @@stars += 1
      puts
      puts "You have gained #{@@stars} Stars."
      puts
    else
      puts `clear`
      puts
      puts "Incorrect, please try again"
      puts
      self.author_most_book
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
      puts 'clear'
      puts "Great job! #{author_name} did write #{book_by_author[0]}!"
      @@stars += 1
      puts
      puts "You have gained #{@@stars} Stars."
      puts
    else
      puts 'clear'
      puts
      puts "Incorrect. Try again."
      puts
      self.books_by_author
    end

  end


    # user_guess = gets.chomp




  # User provides a publisher name,
  # Then a list of all of their book titles and authors (creator) is returned
  def books_by_publisher
    author_count =0
    publisher_name = nil
    Publisher.all.each do |publisher|
      if publisher.creators.count > author_count
        author_count = publisher.creators.count
        publisher_name = publisher.name
      end
    end
    puts "3. Which publisher has most authors?"
    puts
    puts "   a.Well Go USA"
    puts
    puts "   b.#{publisher_name}"
    puts
    puts "   c.20th Century Fox Home Entertainment,"
    user_choice = self.user_answer
    if user_choice == "b" || user_choice == "B"
      puts `clear`
      puts
      puts "Correct!!, #{publisher_name} has #{author_count} authors."
    else
      puts `clear`
      puts
      puts "Incorrect, Please try again"
      puts
      self.books_by_publisher
    end
  end

  def usage_class_percentage
    physical_count = 0
    digital_count = 0
    total_count =0
    Book.all.each do |book|
      total_count += 1
      if book.usage_class == "Physical"
        physical_count += 1
      else
        digital_count += 1
      end
    end
    digital_percent = digital_count / total_count.to_f * 100 #36.9% digital
    physical_percent = physical_count / total_count.to_f * 100 #63.1% physical
    puts "Choose the correct percent usages between 'Physical' and 'Digital' formats."
    puts
    puts "   a.Physical 51.4%, Digital 48.6%."
    puts
    puts "   b.Physical 63.1%, Digital 36.9%."
    puts
    puts "   c.Physical 36.9%, Digital 63.1%."
    user_choice = self.user_answer
    if user_choice == "b" || user_choice == "B"
      puts `clear`
      puts
      puts "Correct!!, Physical has #{physical_percent}% and Digital has #{digital_percent}% usages."
      @@stars += 1
      puts "You have gained #{@@stars} Stars."
    else
      puts `clear`
      puts
      puts "Incorrect, Please try again"
      puts
      self.usage_class_percentage
    end
  end
end #end of class
