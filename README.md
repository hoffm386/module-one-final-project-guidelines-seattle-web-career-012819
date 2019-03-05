# LIBRARY GUESSING GAME

# Watch an Overview Video About the Game
  Link: https://youtu.be/tMvm1H2QGuI

# Project Description
The Library Trivia Guessing Game is a data analytics project that explores facts from the Seattle Public Library's checkout data. Learn facts about books, authors, publishers and the types of media checked out in Seattle.

This game is a collaborative project by Yong Liang and Ellen Hatleberg. It's purpose is to utilize concepts learned during Module 1 of Flatiron School's Coding Bootcamp. For this data analytics project, ActiveRecord was used to access a Sqlite3 Database. The database was seeded using data collected from the Checkouts by Title API of the Seattle Public Library data available from https://data.seattle.gov.

The project includes three models: Author, Publisher and Book. The Book is the join model. A publisher has many authors through books and vice versa. A command line interface (CLI) is provided for users to play the game, input their answers to questions and see question solutions.

Data Used: https://data.seattle.gov/resource/tmmm-ytt6.json
Dataset Description: https://data.seattle.gov/Community/Checkouts-by-Title/tmmm-ytt6

# Install Instructions
Follow the below steps to play the game:
1. Make sure that you have Ruby installed on your computer. It can be downloaded here: https://www.ruby-lang.org/en/downloads/
2. Open Terminal
3. Navigate to the Project folder
4. Type into the Terminal:
```
bundle install
rake db:migrate
rake db:seed
ruby bin/run.rb
```

# A Contributors Guide
If you are interested in making a contribution to this project, let us start by saying, THANK YOU. As learners, interested in improving our code, we appreciate your feedback.

Ways to contribute:
1. Reporting Bugs
2. Suggesting Enhancements

# Link to the license
https://github.com/ehatlebe/module-one-final-project-guidelines-seattle-web-career-012819/blob/master/LICENSE.md

### User Stories

* As a user, I want to find out which author has written the most books.
* As a user, I want to learn which book an author has written.
* As a user, I want to find out which publisher has the most authors.
* As a user, I want to learn which author wrote a specific book.
* As a user, I want to find out the percent of total records checked out of a specific type (Physical or Digital).
