class Command_line_interface

  def welcome
    puts "********* Welcome to the Library Trivia Game *********"
  end

  def user_answer_input
    puts "Question one:"
    puts "What is the most popular books in 2018"
    answer = gets.chomp
  end

end #end of class
