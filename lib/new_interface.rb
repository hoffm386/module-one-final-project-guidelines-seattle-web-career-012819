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
          "Find All Books by a Given Price",
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

      {
        title: "Book Search by Genre",
        header: "Please enter a genre to find:",
        body: []
      },

      {
        title: "Book Search by Price",
        header: "Please enter a price to find:",
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
    if ( self.current_menu == (-1) )
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
      if self.current_menu != 0
        if self.expect_search_term
          if user_input
            # Point to the method we want to run
            method_to_call = get_data_from_menu_command
            # Store the result of the query
            if method_to_call
              results_hash = method_to_call.call(user_input)
              # Update the menu with the result
              text_hash = results_hash

            end
          end
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
        "\/a to make another request in this menu\n",
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
  end

  ### BEGIN: BASIC REQUESTS (Merged as a failsafe)

  def find_books_by_title(book_title)

    return_data = {
      title: "Matching Book Titles",
      header: "The following books matched your search:",
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

  def find_books_by_author(author_name)
    return_data = {
      title: "Matching Books by Author",
      header: "The following books matched your search:",
      body: []
    }
    self.authors.select { |a|
      a.name.downcase.include?( author_name.downcase )
    }.map { |m|
      m.books
    }.flatten.uniq
    return_data
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

  # def find_books_by_genre(book_genre)
  #   self.books.select { |b|
  #     b.genres.downcase.include?(book_genre.downcase)
  #   }.uniq
  # end

  def find_books_by_keyword(book_keyword)
    self.books.select { |b|
      b.description.downcase.include?( book_keyword.downcase )
    }.uniq
  end

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
    ans = Book.all.select do |book|
      book.genres.downcase.include?(str.downcase) ||
      book.title.downcase.include?(str.downcase)
    end
    puts "\n"
    if ans.empty? 
      pick = ["biography", "cat", "dog", "sports", "humor"]
      puts "Sorry, nothing for that. Perhaps try #{pick.sample}?"
    else
      puts "Here are the books in your genre selection: "
      ans.each do |book|
        puts "#{book.title}, by #{book.authors[0].name}."
      end
    end
  end

  def find_book_by_price(str)
    arr = []
    Book.all.each do |book|
      if book.title.downcase == str.to_s.downcase
          arr << book.price
      end
    end
    if arr[0] > 0
      arr2 = ["Worth it.", "Why not?", "Let's do this!", "It WOULD look good on your bookshelf...", "Can't put a price on a good read, though."]
      puts "\n"
      puts "That one is $#{arr[0]}. #{arr2.sample}"
    else 
      puts "That one isn't for sale right now. We do NOT recommending finding a link to illegaly download it instead."
    end
  end

  def find_cheapest_book
    puts "Calculating prices.."
    2.times do 
      sleep(1) 
      puts"."
    end
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
  end

  def bibs_n_beans
      if @@counter == 0
          puts "\n"
          puts "..."
          sleep(1.second) 
          puts "We can't read."
          puts "\n"
          sleep(1.second) 
          @@counter += 1
      elsif 
          @@counter == 1
          puts "Alright, fine. Bib likes #{random_cat_book}!"
          puts "\n"
          sleep(1.second) 
          @@counter += 1
      elsif
          @@counter == 2
          puts "Beans says you should read #{random_dog_book}!"
          puts "\n"
          sleep(1.second) 
          @@counter = 0
      end
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