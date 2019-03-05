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

  def ask_question(number:, question:, a:, b:, c:, correct_answer:, correct_message:)
    puts <<~QUESTION_TEXT
    #{number}. #{question}

      a. #{a}

      b. #{b}

      c. #{c}

    QUESTION_TEXT

    answer = self.user_answer
    puts `clear`
    system("clear")

    right_answer = answer.downcase == correct_answer

    if right_answer
      @@stars += 1
      puts <<~CORRECT

        #{correct_message}


        You have gained #{@@stars} Star(s).

        *****************************************************
        *****************************************************

      CORRECT
    else
      puts <<~INCORRECT

        Incorrect, please try again
        *****************************************************
        *****************************************************

      INCORRECT
    end
    right_answer
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

    success = ask_question({
      number: 1,
      question: "Which author has written the most books?",
      a: most_authors,
      b: @@wrong_answer_array.sample,
      c: @@wrong_answer_array.sample,
      correct_answer: "a",
      correct_message: "Correct!! #{most_authors} has written #{book_count} books"
    })

    if !success
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

    success = ask_question({
      number: 2,
      question: "Which book did #{author.name} write?",
      a: book_array.sample,
      b: book_array.sample,
      c: book_by_author[0],
      correct_answer: "c",
      correct_message: "Great job! #{author.name} did write #{book_by_author[0]}!"
    })

    if !success
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
    success = ask_question({
      number: 3,
      question: "Which publisher has most authors?",
      a: wrong_publisher_array.sample,
      b: wrong_publisher_array.sample,
      c: publisher_name,
      correct_answer: "c",
      correct_message: "Correct!!, #{publisher_name} has #{author_count} authors."
    })

    if !success
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

    success = ask_question({
      number: 4,
      question: "Who wrote #{book_name}?",
      a: author_rand_name.name,
      b: author.name,
      c: author_rand_name2.name,
      correct_answer: "b",
      correct_message: "Great job! #{book_name} was written by #{author.name}!"
    })

    if !success
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

    success = ask_question({
      number: 5,
      question: "Of total checkouts, choose the percent usage for Physical and Digital formats.",
      a: "Physical #{physical_percent - 20}%, #{digital_percent +20}%",
      b: "Physical #{physical_percent}%, Digital #{digital_percent}%",
      c: "Physical #{digital_percent}, Digital #{physical_percent}%",
      correct_answer: "b",
      correct_message: "Correct!!, Physical has #{physical_percent}% and Digital has #{digital_percent}% usages."
      })

    if !success
      self.usage_class_percentage
    end
  end
end #end of class
