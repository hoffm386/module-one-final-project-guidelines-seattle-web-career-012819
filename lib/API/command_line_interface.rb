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

  # Question 1: Which author has written the most books?
  def author_most_book

    most_prolific_author = Creator.order(books_count: :desc).first
    others = Creator.where.not(id: most_prolific_author.id).sample(2)

    success = ask_question({
      number: 1,
      question: "Which author has written the most books?",
      a: most_prolific_author.name,
      b: others.first.name,
      c: others.second.name,
      correct_answer: "a",
      correct_message: "Correct!! #{most_prolific_author.name} has written #{most_prolific_author.books_count} books"
    })

    if !success
      self.author_most_book
    end

  end #end of method

  #Question 2
  def books_by_author

    random_author = Creator.where("books_count > 0").sample
    random_book = random_author.books.sample
    others = Book.where.not(creator: random_author).sample(2)

    success = ask_question({
      number: 2,
      question: "Which book did #{random_author.name} write?",
      a: others.first.name,
      b: others.second.name,
      c: random_book.name,
      correct_answer: "c",
      correct_message: "Great job! #{random_author.name} did write #{random_book.name}!"
    })

    if !success
      self.books_by_author
    end
  end


  # User provides a publisher name, Method #3
  # Then a list of all of their book titles and authors (creator) is returned
  def books_by_publisher

    publisher_most_authors = Publisher.order(creators_count: :desc).first
    others = Publisher.where.not(id: publisher_most_authors.id).sample(2)

    success = ask_question({
      number: 3,
      question: "Which publisher has most authors?",
      a: others.first.name,
      b: others.second.name,
      c: publisher_most_authors.name,
      correct_answer: "c",
      correct_message: "Correct!!, #{publisher_most_authors.name} has #{publisher_most_authors.creators_count} authors."
    })

    if !success
      self.books_by_publisher
    end
  end


  # Question 4
  def author_of_book

    random_book = Book.all.sample
    random_author = random_book.creator
    others = Creator.where.not(id: random_author.id).sample(2)

    success = ask_question({
      number: 4,
      question: "Who wrote #{random_book.name}?",
      a: others.first.name,
      b: random_author.name,
      c: others.second.name,
      correct_answer: "b",
      correct_message: "Great job! #{random_book.name} was written by #{random_author.name}!"
    })

    if !success
      self.author_of_book
    end
  end


#Question #5 method
  def usage_class_percentage

    physical_count = Book.where(usage_class: "Physical").count
    digital_count = Book.where.not(usage_class: "Physical").count
    total_count = physical_count + digital_count

    digital_percent = digital_count / total_count.to_f * 100 #36.9% digital
    physical_percent = physical_count / total_count.to_f * 100 #63.1% physical

    success = ask_question({
      number: 5,
      question: "Of total checkouts, choose the percent usage for Physical and Digital formats.",
      a: "Physical #{physical_percent - 20}%, Digital #{digital_percent +20}%",
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
