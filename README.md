# Module One Final Project
Eli Merrell and Cris Hanks

#GIT Paid - A CLI application for finding your next Dev job
#GIT Paid interacts with the GITHUB Jobs API which houses hundreds of worldwide Developer job openings

#Overview: Project Vision
As-pitched, we wanted to create an application that interacts with an API and includes the following functionality:

1. Job Hunters should be able to search for all jobs by name
2. Job Hunters should be able to search for jobs by location
3. Job Hunters should be able to search for jobs by technology
4. Job Hunters should be able to favorite jobs and save them to a list
5. Job Hunters should be able to browse favorited jobs
6. Job Hunters should be able to apply for a job

#Populating the Database
1. Open your terminal and navigate to the correct application folder where you cloned the repository
2. Run 'rake db:migrate' to create database tables
3. Run 'rake db:seed' to populate database tables with data gathered from the GITHUB Jobs API

#Running the App
1. Run 'ruby bin/run.rb' in your terminal to open GIT Paid
2. Once open, you'll be greeted with a main menu. Follow the on-screens to navigate

#GIT Paid Features
1. Create User: Allows Job Hunters to create a profile with a name, preferred technologies, and location
2. Search For Jobs: Allows Job Hunters to search GITHUB Jobs API by current user location, any location, title and technology
3. Favorite Jobs to Profile: Allows Job Hunters to pull job info from GITHUB Jobs API and save them to their profile
4. Access Saved Jobs: Remembers all saved jobs and allows users to perform any of the following actions:
  - Delete a favorted post
  - Read the description of a favorited post
  - Return to the main menu
5. Update User Location: Allows users to update their current location, updating and persisting changes to the database
6. Apply for a Job: If URL available in API, redirects Job Hunters to that application link by simply pressing a button
7. Sign Out: GIT Paid allows users to sign out and sign back in, remembering all of the saved profile and job info for future logins
8. Exit: Allows users to quit the application at any point

#Attributions:
You can access the GITHUB Jobs API for free here: https://jobs.github.com/api

#Contributions:
If you would like to view the code and submit any contributions, you may do so here: https://github.com/elimerrell/module-one-final-project-GITPaid-JobSeacrch-CLI 