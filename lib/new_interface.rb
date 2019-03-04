class UserInterface
  attr_accessor :current_menu, :expect_search_term, :is_entering_date

  def initialize()
    @@counter = 0

    @current_menu = 0
    @expect_search_term = false
    @is_entering_date = false
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
      method(:find_books_by_mature),
      method(:books_by_page_count),
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
          "Find Books with Mature Themes",
          "Find Books by Length",
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
        title: "The Cheapest Book",
        header: "The book with the lowest price is:",
        body: []
      },

      {
        title: "Book Search by Maturity Rating",
        header: "Please enter a 'mature' or 'not' to search:",
        body: []
      },

      {
        title: "Find Books by Length",
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
      if ( self.current_menu == 6 || self.current_menu == 7 || self.current_menu == 9 || self.current_menu == 10 )
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

          # Check to make sure there are no numbers in the user's input
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
        # If we find letters using regular expression, throw an error.
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

      if user_input.to_i == 8
        self.is_entering_date = true
      end
    end

    ### Show the appropriate menu and pass the input from the user.
    return show_menu(user_input)
  end

  def grab_bag
    puts "\n"
    puts "Pick your poison:"
    puts "\n"

    book_object_list = Book.all.sample(3)

    shortened_descriptions = book_object_list.map do |book|
      book_description_list = book.description.split(/ /)
      "...#{book_description_list[1..9].join(" ")}..."
    end

    shortened_descriptions.each_with_index do |str, index|
      puts "#{index+1}#{str}"
    end

    input = gets.chomp
    chosen_book = book_object_list[input.to_i - 1]

    puts "\n"
    puts "You've chosen #{chosen_book.title}, by #{chosen_book.authors[0].name}. Happy reading!"
    puts "\n"

    sleep(1.second)

    puts "(Press any key to return to the menu)"
    any_key = gets.chomp
    self.current_menu = 0
    return show_menu

  end

  ### BEGIN: BASIC REQUESTS (Merged as a failsafe)

  def find_books_by_title(book_title)
    body = Book.where("title LIKE ?", "%#{book_title.downcase}%").map do |book|
      "#{book.title} by #{book.authors.first.name}"
    end

    return_data = {
      title: "Matching Book Titles",
      header: "The following titles matched your keyword:",
      body: body
    }

    return_data
  end

  def find_books_by_author(str)
    body = Book.joins(:authors).where("authors.name LIKE ?", "%#{str}").map do |book|
      "#{book.title}, by #{book.authors[0].name}."
    end

    return_data = {
      title: "Matching Books by Author",
      header: "This author has written or collaborated on:",
      body: body
    }

    return_data
  end

  def find_books_by_publisher(str)
    body = Book.joins(:publishers).where("publishers.name LIKE ?", "%#{str}%").map do |book|
      "#{book.title}, by #{book.authors[0].name}."
    end

    return_data = {
      title: "Matching Books by Publisher",
      header: "This publisher has released:",
      body: body
    }

    return_data
  end

  def find_books_by_mature(rating)

    if rating.downcase == "mature"
      matches = Book.where(maturity: "MATURE").sample(10)
    else
      matches = Book.where(maturity: "NOT_MATURE").sample(10)
    end

    if matches.empty?
      header = "Sorry, no books were found to match that maturity rating."
      body = []
    else
      header = "The following books matched your search:"
      body = matches.map do |book|
        title = book.title

        authors = book.authors.map {|author| author.name}.flatten.uniq.join(" & ")

        "#{title} by #{authors}"
      end
    end

    return_data = {
      title: "Book Search by Maturity Rating",
      header: header,
      body: body
    }

    return_data
  end

  def options_display(array)
    puts "Here are some options:"
    array = array.sample(10)
    array.each_with_index do |book, index|
      puts "#{index+1}. #{book.title}, by #{book.authors[0].name}."
    end
  end

  def books_by_page_count
    puts <<~PAGE_COUNT_MENU

    What size of book are you looking for?
    1: Just a bus read. (Under 50 pages)
    2: Give me a weekender. (Between 50 and 200 pages)
    3: Vacation length! (Over 200 pages)

    PAGE_COUNT_MENU

    input = gets.chomp
    puts "\n"

    long_books = Book.where("page_count > 200")
    mid_range = Book.where("page_count BETWEEN 50 AND 200")
    short_books = Book.where("page_count < 50")

    if input.to_i == 1
      options_display(short_books)
    elsif input.to_i == 2
      options_display(mid_range)
    elsif input.to_i == 3
      options_display(long_books)
    else
      puts "That wasn't an option..."
    end
    puts "\e[0m(Press ENTER to return to the menu)"
    any_key = gets.chomp
    self.current_menu = 0
    return show_menu
  end

  def find_books_by_genre(str)

    ans = Book.where("genres LIKE :query OR title LIKE :query", query: "%#{str}%")

    if ans.empty?
      pick = ["biography", "cat", "dog", "sports", "humor"]
      header = "Sorry, nothing for that. Perhaps try:"
      body =  ["#{pick.sample}?"]
    else
      header = "Here are the books in your genre selection: "
      body = ans.map do |book|
        "#{book.title}, by #{book.authors[0].name}."
      end
    end

    return_data = {
      title: "Book Search by Genre",
      header: header,
      body: body
    }

    return_data
  end

  def find_books_by_price(str)

    matches = Book.where("title LIKE :query AND price > 0.0", query: "%#{str}%")

    if matches.length > 0
      match = matches.sample
      arr2 = ["Worth it.", "Why not?", "Let's do this!", "It WOULD look good on your bookshelf...", "Can't put a price on a good read, though."]

      header = "#{match.title} is $#{match.price}. #{arr2.sample}"
    else
      header = ["\x1b[38;5;196mThe book you are looking for isn't for sale right now.", "We do NOT recommend finding a link to illegaly download it instead."].join("\n\n")
    end

    return_data = {
      title: "Pricing Data for a Given Book",
      header: header,
      body: []
    }

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

    cheapest = Book.where("price > 0.0").min_by(&:price)

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
      boo = Book.where("genres LIKE :query OR title LIKE :query", query: "%cat%").sample
      "#{boo.title}, by #{boo.authors[0].name}"
  end

  def random_dog_book
    boo = Book.where("genres LIKE :query OR title LIKE :query", query: "%dog%").sample
    "#{boo.title}, by #{boo.authors[0].name}"
  end

  def exit_program
    # Clear the terminal
    system("clear")

    # Say goodbye
    puts "Thanks for stopping by!"
  end

end # of class
