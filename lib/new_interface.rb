class UserInterface
  attr_reader :authors, :books, :publishers
  attr_accessor :current_menu, :expect_search_term

  def initialize(authors, books, publishers)
    @@counter = 0

    @authors = authors
    @books = books
    @publishers = publishers

    @current_menu = 0
    @expect_search_term = false
  end

  def get_data_from_menu_command
    methods_array = [
      method(:find_books_by_title),
      method(:find_books_by_author),
      method(:find_books_by_publisher),
      method(:find_books_by_genre),
      method(:find_books_by_price),
      method(:grab_bag),
      method(:find_cheapest_book),
      method(:missing_method_1),
      method(:missing_method_2),
      method(:bibs_n_beans),
      method(:exit_program)
    ]
    methods_array[self.current_menu-1]
  end

  def menu_text
    # Define the array of data we can request from
    text_hash_array = [
      ### MAIN MENU ###

      {
        title: "Welcome to Bibs' & Beans' Book Club!",
        # spacer will be printed inside of the menu

        header: "Please choose a number and press ENTER to make a selection:",
        # spacer will be printed inside of the menu

        body: [
          "Find All Books by Title",
          "Find All Books by Author",
          "Find All Books by Publisher",
          "Find All Books by Genre",
          "Find the Price of a Given Book",
          "Request a Grab Bag of Books to Discover",
          "Find the Cheapest Book",
          "Missing 1 (?)",
          "Missing 2 (?)",
          "Bibs' & Beans' Recommendations"
        ]
        # spacer will be printed inside of the menu

        # every menu gets this appended at the bottom by default:
        
          # "You may also type:",
          # "/b to go back to the menu",
          # "/a to search by title again",
          # "/exit to leave the program."

        # spacer will be printed inside of the menu
      },

      {
        title: "Book Search by Title",
        header: "Please enter a title keyword to query:",
        body: []
      },

      {
        title: "Book Search by Author",
        header: "Please enter the author keyword you would like to look up:",
        body: []
      },

      {
        title: "Book Search by Publisher",
        header: "Please enter the publisher keyword you want to browse:",
        body: []
      },

      {
        title: "Book Search by Genre",
        header: "Please enter a genre keyword you want to read more of:",
        body: []
      },

      {
        title: "Search Price by Book",
        header: "Please enter a book title keyword whose price you want to find:",
        body: []
      },

      {
        title: "Grab Bag of Books to Discover",
        header: "We thought you might enjoy giving these a read:",
        body: []
      },

      {
        title: "Cheapest Book",
        header: "The book with the lowest price is:",
        body: []
      },

      {
        title: "Missing 1 (?)",
        header: "Something:",
        body: []
      },

      {
        title: "Missing 2 (?)",
        header: "Something:",
        body: []
      },

      {
        title: "Bibs' & Beans' Recommendations",
        header: "The books that are trending among dogs and cats are:",
        body: []
      }
    ]

    # If something isn't found, smaple from these phrases
    oops_titles = [
      "Oops!",
      "Nothing To See Here...",
      "Uh-oh!",
      "Malfunction...",
      "Danger, Will Robinson!",
      "I'm... Having Difficulties."
    ]

    # Define the return data of this method.
    return_data = text_hash_array[self.current_menu]

    # If we are out of bounds of any options available...
    if return_data == nil
      self.current_menu = 0
      return_data = text_hash_array[self.current_menu]
      return_data[:title] = oops_titles.sample
      return_data[:header] = "Sorry, we didn't recognize that command. Please try again:"
    end

    # Return the data
    return_data
  end

  def show_menu(user_input=nil)
    divert_to_fancy_method = false
    if ( self.current_menu == (-1) )
      # we exit the program
      return exit_program
    else
      if ( self.current_menu == 6 || self.current_menu == 7 || self.current_menu == 10 )
        divert_to_fancy_method = true
      end

      # Clear the terminal
      system("clear")

      # Grab all the text for this menu
      text_hash = menu_text

      # Define our vertical spacer
      new_line = "\n\n"

      # If the user is not in the main menu...
      # And if we are expecting a search term...
      # And we have received user_input...
      if self.current_menu != 0
        if self.expect_search_term
          if divert_to_fancy_method
            return get_data_from_menu_command.call
          end

          if !(user_input =~ /\A[-+]?[0-9]+\z/)
            # Point to the method we want to run
            method_to_call = get_data_from_menu_command
            # Store the result of the query
            if method_to_call
              results_hash = method_to_call.call(user_input)

              # Update the menu with the result, conditionally, if anything has changed.
              if results_hash[:body].length == 0 && self.current_menu != 5
                text_hash[:header]  = "Sorry, we didn't find a match for that. Please try again."
              else
                text_hash[:title]   = results_hash[:title]
                text_hash[:header]  = results_hash[:header]
                text_hash[:body]    = results_hash[:body]
              end
            end
          end
        end
      else
        if user_input && !(user_input =~ /\A[-+]?[0-9]+\z/)
          text_hash[:header]  = "Sorry, we didn't find a match for that. Please try again."
        end
      end


      # Display the title of this location in the program.
      puts "\x1b[48;5;24m\x1b[38;5;255m*   #{text_hash[:title]}   *#{new_line}\e[0m"

      # Display the header of this location in the program.
      # This uses fancy syntax to colorize the command line.
      puts "\e[33m#{text_hash[:header]}\e[0m#{new_line}"

      # Display the body if there is one.
      text_hash[:body].each_with_index do |b, index|
        puts "#{index+1}.\t#{b}"
        if (index == text_hash[:body].length - 1)
          puts "#{new_line}" # Conditionally pad the bottom of the last item on the list
        end
      end

      # Display the footer every menu gets.
      footer_msg = [
        "You may also type:#{new_line}",
        "\/b to go back to the menu\n",
        "\/exit to leave the program\n",
        "another keyword to search.#{new_line}"
      ]

      footer_msg.each_with_index do |f, index|
        if index==0
          puts "\x1b[38;5;248m#{f}"
        else
          if self.current_menu == 0
            if index == 0 || index == 2
              puts "*\t#{f}"
            end
          else
            puts "*\t#{f}"
          end
        end
      end
      print "\e[0m"
      return get_user_input
    end
  end

  def get_user_input
    # Format the input as a downcased string

    user_input = gets.chomp.downcase

    ### Assign a value to @current_menu

    # If the user is entering /b, /exit
    if user_input.include?("/b")
      # go to the main menu
      self.current_menu = 0
      self.expect_search_term = false
    elsif user_input.include?("/exit")
      # exit the program
      self.current_menu = (-1)
    elsif user_input.to_i > 0
      # Set the current_menu to the one the user chose.
      self.current_menu = user_input.to_i

      # Expect a search term.
      self.expect_search_term = true
    end

    ### Show the appropriate menu and pass the input from the user.
    return show_menu(user_input)
  end

  def grab_bag
    puts "\n"
    puts "Pick your poison:"
    puts "\n"

    arr = Book.all.sample(3)

    result = arr.map do |book|
      arr2 = book.description.split(/ /)
      new_str = arr2[1..9].join(" ")
      new_str << "..."
      new_str.prepend("...")
    end

    result.each_with_index do |str, index|
      puts "#{index+1}#{str}"
    end

    input = gets.chomp
    puts "\n"
    puts "You've chosen #{arr[input.to_i - 1].title}, by #{arr[input.to_i - 1].authors[0].name}. Happy reading!"
    puts "\n"
    sleep(1.second)

    puts "(Press any key to return to the menu)"
    any_key = gets.chomp
    self.current_menu = 0
    return show_menu

  end

  ### BEGIN: BASIC REQUESTS (Merged as a failsafe)

  def find_books_by_title(book_title)
    return_data = {
      title: "Matching Book Titles",
      header: "The following titles matched your keyword:",
      body: []
    }

    self.books.select { |b|
      b.title.downcase.include?( book_title.downcase )
    }.each { |e|
      t_str = e.title
      a_str = e.authors.map { |a|
        a.name
      }

      a_str.flatten.uniq.join(" & ")
      if a_str.class == Array
        a_str = a_str[0]
      end

      return_data[:body] << "#{t_str} by #{a_str}"
    }
    return_data
  end

  def find_books_by_author(str)
    return_data = {
      title: "Matching Books by Author",
      header: "This author has written or collaborated on:",
      body: []
    }

    ans = Book.all.select do |book|
      book.authors[0].name.downcase.include?(str.downcase)
    end

    ans.each do |book|
      return_data[:body] << "#{book.title}, by #{book.authors[0].name}."
    end
    return_data
  end

  def find_books_by_publisher(str)
    return_data = {
      title: "Matching Books by Publisher",
      header: "This publisher has released:",
      body: []
    }

    ans = Book.all.select do |book|
      book.publishers[0].name.downcase.include?(str.downcase)
    end

    ans.each do |book|
      return_data << "#{book.title}, by #{book.authors[0].name}."
    end
    return_data
  end

  # def find_books_by_publish_date(book_date)
  #   self.books.select { |b|
  #     b.publish_date.downcase.include?( book_date.downcase )
  #   }.uniq
  # end

  # def find_books_by_page_count(book_pages)
  #   self.books.select { |b|
  #     b.page_count == book_pages
  #   }.uniq
  # end

  # def find_books_by_price(book_price)
  #   self.books.select { |b|
  #     b.price == book_price
  #   }.uniq
  # end

  # def find_books_by_genre(book_genre)
  #   self.books.select { |b|
  #     b.genres.downcase.include?(book_genre.downcase)
  #   }.uniq
  # end

  # def find_books_by_keyword(book_keyword)
  #   self.books.select { |b|
  #     b.description.downcase.include?( book_keyword.downcase )
  #   }.uniq
  # end

  ### END: BASIC REQUESTS

  ### These Methods Need Hashes of:
  ### :title, :header, and :body (an array of strings) added.

  def missing_method_1
    # nothing
  end

  def missing_method_2
    # nothing
  end

  def find_books_by_genre(str)
    return_data = {
      title: "Book Search by Genre",
      header: "",
      body: []
    }
    ans = Book.all.select do |book|
      book.genres.downcase.include?(str.downcase) ||
      book.title.downcase.include?(str.downcase)
    end

    if ans.empty? 
      pick = ["biography", "cat", "dog", "sports", "humor"]
      return_data[:header] = "Sorry, nothing for that. Perhaps try #{pick.sample}?"
    else
      return_data[:header] = "Here are the books in your genre selection: "
      ans.each do |book|
        return_data[:body] << "#{book.title}, by #{book.authors[0].name}."
      end
    end
    return_data
  end

  def find_books_by_price(str)
    return_data = {
      title: "Pricing Data for a Given Book",
      header: "",
      body: []
    }

    arr = []
    Book.all.each do |book|
      if book.title.downcase.include?(str.downcase)
          arr << book.price
      end
    end

    if arr.length > 0
      arr2 = ["Worth it.", "Why not?", "Let's do this!", "It WOULD look good on your bookshelf...", "Can't put a price on a good read, though."]
      
      return_data[:header] = "That book is $#{arr[0]}. #{arr2.sample}"
    else 
      return_data[:header] = ["\x1b[38;5;196mThe book you are looking for isn't for sale right now.", "We do NOT recommend finding a link to illegaly download it instead."].join("\n\n")
    end
    return_data
  end

  def find_cheapest_book
    puts "\x1b[48;5;24m\x1b[38;5;255m*   Thrifty Reading   *\e[0m\n\n"
    print "Calculating prices"
    3.times do 
      sleep(1) 
      print "."
    end

    system("clear")

    puts "\x1b[48;5;24m\x1b[38;5;255m*   Thrifty Reading   *\e[0m\n\n"

    cheapest = nil
    Book.all.each do |book|
      if cheapest == nil
          cheapest = book
      elsif book.price > 0 && book.price < cheapest.price
          cheapest = book
      end
    end
    puts "The cheapest book is #{cheapest.title} by #{cheapest.authors[0].name}, at $#{cheapest.price}. That's basically free!"
    puts "\n"

    puts "(Press ENTER to return to the menu)"
    any_key = gets.chomp
    self.current_menu = 0
    return show_menu

  end

  def bibs_n_beans
    puts "\x1b[48;5;24m\x1b[38;5;255m*   Bibs' & Beans' Recommendations   *\e[0m\n\n"
      if @@counter == 0
          puts "\x1b[38;5;46m...\n\n"
          sleep(1.second) 
          puts "Animals can't read.\n\n"
          sleep(1.second) 
          @@counter += 1
      elsif 
          @@counter == 1
          puts "\x1b[38;5;46mAlright, fine. Bibs likes #{random_cat_book}!\n\n"
          sleep(1.second) 
          @@counter += 1
      elsif
          @@counter == 2
          puts "\x1b[38;5;46mBeans says you should read #{random_dog_book}!\n\n"
          sleep(1.second) 
          @@counter = 0
      end

    puts "\e[0m(Press ENTER to return to the menu)"
    any_key = gets.chomp
    self.current_menu = 0
    return show_menu

  end

  def random_cat_book
      arr =[]
      Book.all.each do |book|
          if book.genres.downcase.include?("cat") || book.title.downcase.include?("cat")
              arr << book
          end
      end
      boo = arr.sample
      "#{boo.title}, by #{boo.authors[0].name}"
  end

  def random_dog_book
      arr =[]
      Book.all.each do |book|
          if book.genres.downcase.include?("dog") || book.title.downcase.include?("dog")
              arr << book
          end
      end
      boo = arr.sample
      "#{boo.title}, by #{boo.authors[0].name}"
  end

  def exit_program
    # Clear the terminal
    system("clear")

    # Say goodbye
    puts "Thanks for stopping by!"
  end

end # of class