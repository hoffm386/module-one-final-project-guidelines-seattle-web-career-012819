class Command_line_interface

  def welcome
    puts "********* Welcome to the Library Trivia Game *********"
    puts "(Please choose the correct answers for each questions)"
  end

  def question_01
    puts "1. Which author has written the most books?"
    print ""
    answer = gets.chomp
  end

  def books_by_publisher
    print "Enter a publisher name: "
    publisher_name = gets.chomp
    publisher = Publisher.find_by name: publisher_name
    puts publisher.books.map {|book| "#{book.name} | #{book.creator.name}"}
  end

end #end of class
