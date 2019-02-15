class UserInterface
  attr_reader :authors, :books, :publishers
  attr_accessor :current_menu, :expect_search_term

  def initialize(authors, books, publishers)
      @authors = authors
      @books = books
      @publishers = publishers
      @current_menu = 0
      @expect_search_term = false
  end

  def get_user_input
    # Format the input as a string and downcase it
    user_input = gets.chomp.to_s.downcase

    ### Assign a value to @current_menu

    # If the user is entering /a, /b, /exit
    if user_input.include?("/a")
      # reload the current menu (don't change self.current_menu)
    elsif user_input.include?("/b")
      # go to the main menu
      self.current_menu = 0
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
          "Find a book by its title",
          "Find all books by an author",
          "Find all books by publisher",
          "Find books by genre",
          "Play BookRoulette",
          "Bib & Beans' recommendations",
        ],
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
        header: "Please enter a title to find:",
        body: []
      },

      {
        title: "Book Search by Author",
        header: "Please enter a author to find:",
        body: []
      },

      {
        title: "Book Search by Publisher",
        header: "Please enter a publisher to find:",
        body: []
      },
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
    if (self.current_menu == (-1) )
      # we exit the program
      return exit_program

    else
      # Grab all the text for this menu
      text_hash = menu_text

      # Define our vertical spacer
      new_line = "\n\n"

      # If the user is not in the main menu...
      # And if we are expecting a search term...
      # And we have received user_input...
      if self.current_menu != 0 && self.expect_search_term && user_input
        # Point to the method we want to run
        method_to_call = get_data_from_menu_command
        # Store the result of the query
        if method_to_call
          results_body = method_to_call.call(user_input)
          # Update the menu with the result
          text_hash[:body] = results_body
        end
      end

      system("clear") # Clear the terminal

      # Display the title of this location in the program.
      puts "#{text_hash[:title]}#{new_line}"

      # Display the header of this location in the program.
      puts "#{text_hash[:header]}#{new_line}"

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
        "\/a to search by title again\n",
        "\/exit to leave the program.#{new_line}"
      ]

      footer_msg.each_with_index do |f, index|
        if index==0
          puts "#{f}"
        else
          puts "*\t#{f}"
        end
      end

      return get_user_input
    end
  end

  def get_data_from_menu_command
    methods_array = [
      method(:find_books_by_title),
      method(:find_books_by_author),
      method(:find_books_by_publisher),
      method(:find_books_by_publish_date),
      method(:find_books_by_page_count),
      method(:find_books_by_price),
      method(:find_books_by_genre),
      method(:find_books_by_keyword)
    ]
    methods_array[self.current_menu-1]
  end

  ### BEGIN: BASIC REQUESTS (Merged as a failsafe)

  def find_books_by_title(book_title)
    self.books.select { |b|
      b.title.downcase.include?( book_title.downcase )
    }
  end

  def find_books_by_author(author_name)
    self.authors.select { |a|
      a.name.downcase.include?( author_name.downcase )
    }.map { |m|
      m.books
    }.flatten.uniq
  end

  def find_books_by_publisher(publisher_name)
    self.publishers.select { |p|
      p.name.downcase.include?( publisher_name.downcase )
    }.map { |m|
      m.books
    }.flatten.uniq
  end

  def find_books_by_publish_date(book_date)
    self.books.select { |b|
      b.publish_date.downcase.include?( book_date.downcase )
    }.uniq
  end

  def find_books_by_page_count(book_pages)
    self.books.select { |b|
      b.page_count == book_pages
    }.uniq
  end

  def find_books_by_price(book_price)
    self.books.select { |b|
      b.price == book_price
    }.uniq
  end

  def find_books_by_genre(book_genre)
    self.books.select { |b|
      b.genres.downcase.include?(book_genre.downcase)
    }.uniq
  end

  def find_books_by_keyword(book_keyword)
    self.books.select { |b|
      b.description.downcase.include?( book_keyword.downcase )
    }.uniq
  end

  ### END: BASIC REQUESTS

  def book_roulette
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
  end

  def exit_program
    # Clear the terminal
    system("clear")

    # Say goodbye
    puts "Thanks for stopping by!"
  end

end # of class