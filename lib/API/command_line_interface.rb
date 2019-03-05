class CommandLineInterface
  @@stars = 0
  # Introduction to the Guessing Game
  def welcome
    puts <<-WELCOME

               LIBRARY TRIVIA GAME

         ************       ************
         *  _______     *     _______  *
         *  _______     *     _______  *
         *  _______     *     _______  *
         *  _______     *     _______  *
         *  _______     *     _______  *
         *              *              *
         ************       ************
                       ***

    WELCOME
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

    puts <<~MOST_BOOKS

      1. Which author has written the most books?

      a. #{most_authors}

      b. #{@@wrong_answer_array.sample}

      c. #{@@wrong_answer_array.sample}

    MOST_BOOKS

    answer = self.user_answer
    if answer == "a" || answer == "A"
      puts `clear`
      system("clear")
      @@stars += 1
      puts <<~MOST_BOOKS_CORRECT

        Correct!! #{most_authors} has written #{book_count} books


        You have gained #{@@stars} Star(s).

        *****************************************************
        *****************************************************

      MOST_BOOKS_CORRECT
    else
      puts `clear`
      system("clear")
      puts <<~MOST_BOOKS_INCORRECT

        Incorrect, please try again
        *****************************************************
        *****************************************************

      MOST_BOOKS_INCORRECT
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
    puts <<~BY_AUTHOR

      2. Which book did #{author.name} write?

        a. #{book_array.sample}

        b. #{book_array.sample}

        c. #{book_by_author[0]}

    BY_AUTHOR
    # Ask user for their answer
    user_guess = self.user_answer
    # Check user's answer
    if user_guess == "c" || user_guess == "C"
      system("clear")
      @@stars += 1
      puts <<~BY_AUTHOR_CORRECT
        Great job! #{author.name} did write #{book_by_author[0]}!


        You have gained #{@@stars} Stars.

        *****************************************************
        *****************************************************

      BY_AUTHOR_CORRECT
    else
      system("clear")
      puts <<~BY_AUTHOR_INCORRECT

        Incorrect. Try again.
        *****************************************************
        *****************************************************

      BY_AUTHOR_INCORRECT
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
    puts <<~MOST_PUBLISHER
    3. Which publisher has most authors?

       a. #{wrong_publisher_array.sample}

       b. #{wrong_publisher_array.sample}

       c. #{publisher_name}

    MOST_PUBLISHER
    user_choice = self.user_answer
    if user_choice == "c" || user_choice == "C"
      system("clear")
      @@stars += 1
      puts <<~MOST_PUBLISHER_CORRECT

        Correct!!, #{publisher_name} has #{author_count} authors.


        You have gained #{@@stars} Stars.

        **********************************************************
        **********************************************************

      MOST_PUBLISHER_CORRECT
    else
      system("clear")
      puts <<~MOST_PUBLISHER_INCORRECT

      Incorrect, Please try again"
      **********************************************************"
      **********************************************************"
      puts
      MOST_PUBLISHER_INCORRECT
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
    puts <<~BY_BOOK
      4. Who wrote #{book_name}?

        a. #{author_rand_name.name}

        b. #{author.name}

        c. #{author_rand_name2.name}
    BY_BOOK
    # Ask user for their answer
    user_guess = self.user_answer

    # Check user's answer
    if user_guess == "b" || user_guess == "B"
      system("clear")
      @@stars += 1
      puts <<~BY_BOOK_CORRECT

        Great job! #{book_name} was written by #{author.name}!


        You have gained #{@@stars} Stars.
        Your session is completed

        *****************************************************
        *****************************************************

      BY_BOOK_CORRECT
    else
      system("clear")
      puts <<~BY_BOOK_INCORRECT

        Incorrect. Try again.
        *****************************************************
        *****************************************************

      BY_BOOK_INCORRECT
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
    puts <<~PHYSICAL_DIGITAL
      5. Of total checkouts, choose the percent usage for Physical and Digital formats.

         a.Physical #{physical_percent - 20}%, #{digital_percent +20}%.

         b.Physical #{physical_percent}%, Digital #{digital_percent}%.

         c.Physical #{digital_percent}, Digital #{physical_percent}%.
    PHYSICAL_DIGITAL
    user_choice = self.user_answer
    if user_choice == "b" || user_choice == "B"
      system("clear")
      @@stars += 1

      puts <<~PHYSICAL_DIGITAL_CORRECT

        Correct!!, Physical has #{physical_percent}% and Digital has #{digital_percent}% usages.


        You have gained #{@@stars} Stars.

        THANK YOU FOR PLAYING

      PHYSICAL_DIGITAL_CORRECT
    else
      system("clear")
      puts <<~PHYSICAL_DIGITAL_INCORRECT

        Incorrect, Please try again
        *****************************************************
        *****************************************************

      PHYSICAL_DIGITAL_INCORRECT
      self.usage_class_percentage
      end
    end
  end #end of class
