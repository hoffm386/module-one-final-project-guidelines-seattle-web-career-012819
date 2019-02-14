class CLI

puts <<-EOF

$$$$$$\\  $$$$$$\\ $$\\           $$$$$$$\\           $$\\       $$\\
$$  __$$\\ \\_$$  _|$$ |          $$  __$$\\          \\__|      $$ |
$$ /  \\__|  $$ |$$$$$$\\         $$ |  $$ |$$$$$$\\  $$\\  $$$$$$$ |
$$ |$$$$\\   $$ |\\_$$  _|        $$$$$$$  |\\____$$\\ $$ |$$  __$$ |
$$ |\\_$$ |  $$ |  $$ |          $$  ____/ $$$$$$$ |$$ |$$ /  $$ |
$$ |  $$ |  $$ |  $$ |$$\\       $$ |     $$  __$$ |$$ |$$ |  $$ |
\\$$$$$$  |$$$$$$\\ \\$$$$  |      $$ |     \\$$$$$$$ |$$ |\\$$$$$$$ |
 \\______/ \\______| \\____/       \\__|      \\_______|\\__| \\_______|
EOF

  def welcome
    puts
    puts "Welcome to GIT Paid, the Dev job search tool you've been waiting for.".colorize(:color => :blue, :background => :white)
    puts
    puts  "Have you already signed up (y/n)?".colorize(:green)
    sign_up_response = gets.chomp.downcase
    if sign_up_response == 'y'
      main_menu
    elsif sign_up_response == 'n'
      sign_up
    else
      invalid_response
      welcome
    end
  end

  def sign_up
    puts "Welcome to the Dev Job Hunter sign up!".colorize(:green)
    puts
    puts "Please enter your name".colorize(:green)
    hunter_name = gets.chomp.downcase
    puts
    puts "Welcome, #{hunter_name.capitalize}!".colorize(:color => :light_blue, :background => :white)
    puts
    puts "Please enter the tecnhologies you are fluent in i.e. ruby,java,javascript".colorize(:green)
    hunter_tecnhologies = gets.chomp.downcase
    puts
    puts "Please enter your current location".colorize(:green)
    hunter_location = gets.chomp.downcase
    current_job_hunter = create_job_hunter(hunter_name,hunter_tecnhologies,hunter_location)
    puts "----------------------------------------------"
    puts "Thanks for signing up, #{hunter_name.capitalize}. Your User ID is: #{current_job_hunter['id']}.".colorize(:color =>:light_blue, :background => :white)
    puts
    puts "Please use your User ID to access your saved jobs.".colorize(:green)
    puts
    puts "Happy Searching!".colorize(:green)
    sleep(2)
    main_menu
  end

  #** create sign in method (asks for your user id, makes sure that id exists in the jobhunters table, and returns that number)

  def main_menu
    puts
    puts "What would you like to do?".colorize(:color => :light_blue, :background =>:white)
    puts "---------------------"
    puts "1. Search Developer Jobs".colorize(:color => :light_blue, :background => :white)
    puts "---------------------"
    puts "2. See Saved Jobs".colorize(:color => :light_blue, :background => :white)
    puts "---------------------"
    puts "3. Apply from saved jobs".colorize(:color => :light_blue, :background => :white)
    puts "---------------------"
    main_menu_response = gets.chomp.downcase
    if main_menu_response == "1"
      search_jobs
    elsif main_menu_response == "2"
      saved_jobs
    elsif main_menu_response == "3"
      apply_job
    else
      invalid_response
      main_menu
    end
  end

  def search_jobs
    puts
    puts "How would you like to search?".colorize(:green)
    puts
    puts "1. Search by location".colorize(:color => :light_blue, :background => :white)
    puts "---------------------"
    puts "2. Search by title".colorize(:color => :light_blue, :background => :white)
    puts "---------------------"
    puts "3. Search by tecnhologies".colorize(:color => :light_blue, :background => :white)
    puts "---------------------"
    search_jobs_response = gets.chomp.downcase

    if search_jobs_response == "1"
      search_by_location
    elsif search_jobs_response == "2"
      search_by_title
    elsif search_jobs_response == "3"
      search_by_technologies
    else
      invalid_response
      search_jobs
    end
  end

  def search_by_location
    puts
    puts "Please enter the location where you want to work".colorize(:green)
    user_location_response = gets.chomp.downcase
    jobs_by_location = JobPosting.joins(:branch).where('LOWER(branches.location) LIKE ?', "%#{user_location_response}%")
    if jobs_by_location.count > 0
      puts "Here are the jobs in your area:".colorize(:green)
      puts
      jobs_by_location.each_with_index.map {|job,index| puts "#{index + 1}. #{job[:title]}"}
      puts
      want_to_save = would_you_like_to_save?
      if want_to_save == 'y'
        user_id = enter_user_id
        if JobHunter.find_by(:id => user_id)
          puts "Please enter the number for the job you would like to save: ".colorize(:green)
          user_saved_response = gets.chomp.to_i
          #check to see if user response is valid
          if user_saved_response > 0 && user_saved_response <= jobs_by_location.count
            job = jobs_by_location[user_saved_response - 1]
            hunter = user_id
            posting = JobPosting.find(job["id"])['id']
            if JobPosting.find_by(:id => posting)
              save_job(hunter,posting)
              job_has_been_saved
              main_menu
            else
              invalid_response
              search_by_location
            end
          else
            invalid_response
            search_by_location
          end
        else
          incorrect_id
          search_by_location
        end
      elsif want_to_save == 'n'
        main_menu
      else
        invalid_response
        search_by_location
      end
    else
      no_results
      search_by_location
    end
  end

  def search_by_title
    puts
    puts "Please enter the job title you would like to search".colorize(:green)
    user_job_title_response = gets.chomp.downcase
    jobs_by_title = JobPosting.where("job_postings.title LIKE ?", "%#{user_job_title_response}%")
    if jobs_by_title.count > 0
      puts "Here are the current openings with similar titles:".colorize(:green)
      puts
      jobs_by_title.each_with_index.map {|job,index| puts "#{index + 1}. #{job[:title]}"}
      puts
      want_to_save = would_you_like_to_save?
      if want_to_save == 'y'
        user_id = enter_user_id
        #*****************can we make this check for the unique id of this actual user?*********************
        if JobHunter.find_by(:id => user_id)
          puts "Please enter the number for the job you would like to save: ".colorize(:green)
          user_saved_response = gets.chomp.to_i
          #check to see if user response is valid
          if user_saved_response > 0 && user_saved_response <= jobs_by_title.count
            #return the hash of the job that the job hunter wants to save
            job = jobs_by_title[user_saved_response - 1]
            #get the id of the most recently added jub hunter in the database
            hunter = user_id
            #get the id of the job posting that matches the job they want to save
            posting = JobPosting.find(job["id"])['id']
            if JobPosting.find_by(:id => posting)
              save_job(hunter,posting)
              job_has_been_saved
              main_menu
            else
              invalid_response
              search_by_title
            end
          else
            invalid_response
            search_by_title
          end
        else
          incorrect_id
          search_by_title
        end
      elsif want_to_save == 'n'
        main_menu
      else
        invalid_response
        search_by_title
      end
    else
      no_results
      search_by_title
    end
  end

  def search_by_technologies
    puts "Please enter the technology you would like to find: "
    user_technology_response = gets.chomp

    #************************how can we search multiple in one search?**************************

    jobs_by_technology = JobPosting.where("job_postings.description LIKE ?", "%#{user_technology_response}%")

    if jobs_by_technology.count > 0
      puts "Here are the jobs that match your search: "
      puts
      jobs_by_technology.each_with_index.map {|job,index| puts "#{index + 1}. #{job[:title]}"}
      puts
      want_to_save = would_you_like_to_save?
      if want_to_save == 'y'
        user_id = enter_user_id
        if JobHunter.find_by(:id => user_id)
          puts "Please enter the number for the job you would like to save: ".colorize(:green)
          user_saved_response = gets.chomp.to_i
          #check to see if user response is valid
          if user_saved_response > 0 && user_saved_response <= jobs_by_technology.count
            #return the hash of the job that the job hunter wants to save
            job = jobs_by_technology[user_saved_response - 1]
            #get the id of the most recently added jub hunter in the database
            hunter = user_id
            #get the id of the job posting that matches the job they want to save
            posting = JobPosting.find(job["id"])['id']
            if JobPosting.find_by(:id => posting)
              save_job(hunter,posting)
              job_has_been_saved
              main_menu
            else
              invalid_response
              search_by_technologies
            end
          else
          invalid_response
          search_by_technologies
          end
        else
          incorrect_id
          search_by_technologies
        end
      elsif want_to_save == 'n'
        main_menu
      else
        invalid_response
        search_by_technologies
      end
    else
      no_results
      search_by_technologies
    end
  end

  def saved_jobs
    user_id = enter_user_id
    current_job_hunter = JobHunter.find_by(:id => user_id)
    if current_job_hunter
      saved_postings = SavedPosting.where(:job_hunter_id => current_job_hunter.id)
      job_titles = saved_postings.each_with_index.map {|posting, index| puts "#{index + 1}. #{posting.job_posting.title}"}
      puts
      jobs = saved_postings.each_with_index.map {|posting| posting}
    else
      incorrect_id
      saved_jobs
    end
    puts "Would you like to delete a posting? (y/n)"
    user_response_input = gets.chomp.downcase
    if user_response_input == 'y'
      puts 'Please enter the number of the job you would like to delete: '.colorize(:green)
      user_delete_input = gets.chomp.to_i
      if user_delete_input > 0 && user_delete_input <= jobs.count
        job_to_delete = jobs[user_delete_input - 1]
        job_to_delete.destroy
        puts "Job successfully deleted. Here are your saved jobs: ".colorize(:light_blue)
        main_menu
      else
        invalid_response
        saved_jobs
      end
      puts
      updated_saved_postings = SavedPosting.where(:job_hunter_id => current_job_hunter.id)
      updated_job_titles = updated_saved_postings.each_with_index.map {|posting, index| puts "#{index + 1}. #{posting.job_posting.title}"}
    else
      invalid_response
      saved_jobs
    end
  end


  def apply_job
    user_id = enter_user_id
    current_job_hunter = JobHunter.find_by(:id => user_id)
    if current_job_hunter
      saved_postings = SavedPosting.where(:job_hunter_id => current_job_hunter.id)
      printed_titles = saved_postings.each_with_index.map {|posting, index| puts "#{index + 1}. #{posting.job_posting.title}"}
      job_titles = saved_postings.each_with_index.map {|posting| posting}
      puts
    else
      incorrect_id
      apply_job
    end

    puts "Please enter the number for the job you would like to apply for: ".colorize(:green)
    user_saved_response = gets.chomp.to_i
    if user_saved_response > 0 && user_saved_response <= job_titles.count
      job = job_titles[user_saved_response - 1]
      application_link = job.job_posting['application_link']


      match = /href\s*=\s*"([^"]*)"/.match(application_link)
      if match
        url = match[1]
      else
        puts "No url provided."
      end
      puts "Opening link to application".colorize(:green)
      sleep(2)
      system('open', url)
      main_menu
    else
      invalid_response
      apply_job
    end
  end

  def would_you_like_to_save?
    puts "Would you like to save any of these jobs? (y/n)".colorize(:green)
    user_save_input = gets.chomp.downcase
  end

  def enter_user_id
    puts "Please enter your User ID: ".colorize(:green)
    user_id_response = gets.chomp.to_i
  end

  def save_job(hunter,posting)
    SavedPosting.find_or_create_by(
      job_hunter_id: hunter,
      job_posting_id: posting
    )
  end

  def incorrect_id
    puts "User ID is incorrect. Please try again.".colorize(:red)
  end

  def job_has_been_saved
    puts "This job has been saved to your favorites.".colorize(:light_blue)
  end

  def create_job_hunter(hunter_name,hunter_tecnhologies,hunter_location)
    current_job_hunter = JobHunter.find_or_create_by(
      name: hunter_name,
      skills: hunter_tecnhologies,
      location: hunter_location
      )
  end

  def invalid_response
    puts "Please enter a valid command!".colorize(:red)
  end

  def no_results
    puts "Whoops! This search didn't return any results. Please try again!".colorize(:red)
  end


end #end of cli class
