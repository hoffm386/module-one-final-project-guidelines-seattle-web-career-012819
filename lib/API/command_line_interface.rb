class Command_line_interface
  @@stars = 0
  # Introduction to the Guessing Game
  def welcome
      puts "           LIBRARY TRIVIA GAME"
      puts
      puts "     ************       ************"
      puts "     *  _______     *     _______  *"
      puts "     *  _______     *     _______  *"
      puts "     *  _______     *     _______  *"
      puts "     *  _______     *     _______  *"
      puts "     *  _______     *     _______  *"
      puts "     *              *              *"
      puts "     ************       ************"
      puts "                   ***"
      puts
  end

  # Method to get back the user's answer in each question
  def user_answer
    puts
    puts "Choose the correct answer (a, b or c): "
    print "Your Answer:"
    gets.chomp
  end

  #this method returns all book names in an array
  def book_names
    Book.all.map do |book|
      book.name
    end
  end
#this method returns all author names in an array
  def author_names(exclude_name)
    Creator.all.select do |author|
      author.name != exclude_name
    end
  end
  # Question 1: Which author has written the most books?
  def author_most_book
    welcome
    most_authors = nil
    book_count =0
    @@wrong_answer_array = [] #this array contains all wrong answers
    Creator.all.each do |creator|
      if creator.books.count > book_count
        book_count = creator.books.count
        most_authors = creator.name
      else
        @@wrong_answer_array << creator.name
      end
    end
    puts
    puts "1. Which author has written the most books?"
    puts
    puts "a. #{most_authors}"
    puts
    puts "b. #{@@wrong_answer_array.sample}"
    puts
    puts "c. #{@@wrong_answer_array.sample}"
    puts
    answer = self.user_answer
    if answer == "a" || answer == "A"
      puts `clear`
      system("clear")
      puts
      puts "Correct!! #{most_authors} has written #{book_count} books"
      @@stars += 1
      puts
      puts "You have gained #{@@stars} Star(s)."
      puts
      puts "*****************************************************"
      puts "*****************************************************"
      puts
    else
      puts `clear`
      system("clear")
      puts
      puts "Incorrect, please try again"
      puts "*****************************************************"
      puts "*****************************************************"
      puts
      self.author_most_book
    end
  end #end of method

  #Question 2
  def books_by_author
    author_name_array =[]
    random_index = rand(0..100)
    book_array = self.book_names
    # Set the author's name that the question will search for random names
    Creator.all.each do |author|
      if author.name != "Unknown Authors"
        author_name_array << author.name
      end
    end
    author_name = "#{author_name_array[random_index]}"
    # Find the book written by author_name
    author = Creator.find_by name: author_name
    book_by_author = author.books.map {|book| "#{book.name}"}
    # Question and answers (c is correct)
    puts "2. Which book did #{author.name} write?"
    puts
    puts "  a. #{book_array.sample}"
    puts
    puts "  b. #{book_array.sample}"
    puts
    puts "  c. #{book_by_author[0]}"
    # Ask user for their answer
    user_guess = self.user_answer
    # Check user's answer
    if user_guess == "c" || user_guess == "C"
      system("clear")
      puts "Great job! #{author.name} did write #{book_by_author[0]}!"
      puts
      @@stars += 1
      puts
      puts "You have gained #{@@stars} Stars."
      puts
      puts "*****************************************************"
      puts "*****************************************************"
      puts
    else
      system("clear")
      puts
      puts "Incorrect. Try again."
      puts "*****************************************************"
      puts "*****************************************************"
      puts
      self.books_by_author
    end
  end


  # User provides a publisher name, Method #3
  # Then a list of all of their book titles and authors (creator) is returned
  def books_by_publisher
    author_count =0
    publisher_name = nil
    wrong_publisher_array = []
    Publisher.all.each do |publisher|
      if publisher.creators.count > author_count
        author_count = publisher.creators.count
        publisher_name = publisher.name
      else
        wrong_publisher_array << publisher.name
      end
    end
    puts "3. Which publisher has most authors?"
    puts
    puts "   a. #{wrong_publisher_array.sample}"
    puts
    puts "   b. #{wrong_publisher_array.sample}"
    puts
    puts "   c. #{publisher_name}"
    user_choice = self.user_answer
    if user_choice == "c" || user_choice == "C"
      system("clear")
      puts
      puts "Correct!!, #{publisher_name} has #{author_count} authors."
      puts
      @@stars += 1
      puts
      puts "You have gained #{@@stars} Stars."
      puts
      puts "**********************************************************"
      puts "**********************************************************"
      puts
    else
      system("clear")
      puts
      puts "Incorrect, Please try again"
      puts "**********************************************************"
      puts "**********************************************************"
      puts
      self.books_by_publisher
    end
  end


  # Question 4
  def author_of_book
    # Set the book that the question will search for the author of
    index_random = rand(1..6)
    book_name = self.book_names[index_random]

    # Find the author that created the book
    book = Book.find_by name: book_name
    author = book.creator
    # author_of_book = book.creators.map {|book| "#{book.name}"}
    author_rand_name = self.author_names(author).sample
    author_rand_name2 = self.author_names(author).sample
    # Question and answers (c is correct)
    puts "4. Who wrote #{book_name}?"
    puts
    puts "  a. #{author_rand_name.name}"
    puts
    puts "  b. #{author.name}"
    puts
    puts "  c. #{author_rand_name2.name}"

    # Ask user for their answer
    user_guess = self.user_answer

    # Check user's answer
    if user_guess == "b" || user_guess == "B"
      system("clear")
      puts
      puts "Great job! #{book_name} was written by #{author.name}!"
      puts
      @@stars += 1
      puts
      puts "You have gained #{@@stars} Stars."
      puts "Your session is completed"
      puts
      puts "*****************************************************"
      puts "*****************************************************"
      puts
    else
      system("clear")
      puts
      puts "Incorrect. Try again."
      puts "*****************************************************"
      puts "*****************************************************"
      puts
      self.author_of_book
    end
  end


#Question #5 method
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
    puts "5. Of total checkouts, choose the percent usage for Physical and Digital formats."
    puts
    puts "   a.Physical #{physical_percent - 20}%, #{digital_percent +20}%."
    puts
    puts "   b.Physical #{physical_percent}%, Digital #{digital_percent}%."
    puts
    puts "   c.Physical #{digital_percent}, Digital #{physical_percent}%."
    user_choice = self.user_answer
    if user_choice == "b" || user_choice == "B"
      system("clear")
      puts
      puts "Correct!!, Physical has #{physical_percent}% and Digital has #{digital_percent}% usages."
      puts
      @@stars += 1
      puts
      puts "You have gained #{@@stars} Stars."
      puts
      puts "THANK YOU FOR PLAYING"
      puts
      puts
    else
      system("clear")
      puts
      puts "Incorrect, Please try again"
      puts "*****************************************************"
      puts "*****************************************************"
      puts
      self.usage_class_percentage
      end
    end
  end #end of class
