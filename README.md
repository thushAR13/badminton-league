# Badminton League Leaderboard

A simple, fast, and robust Ruby on Rails application designed to track badminton match results, manage a roster of players, and automatically generate a leaderboard based on wins and losses.

## Features

* Live Leaderboard: Players are automatically ranked by their total number of wins. Ties are broken by the fewest number of losses.
* Match Recording: Easily log matches by selecting a Winner and a Loser from the current roster.
* Player Management: Add new players to the league or remove them. (Players with existing match history are protected from accidental deletion to preserve leaderboard integrity).
* Match History: A complete, chronological audit log of all matches played.

## Tech Stack

* Framework: Ruby on Rails 8
* Database: SQLite (Default) / PostgreSQL ready
* Styling: Bootstrap 5 (via CDN)
* Testing: RSpec & FactoryBot

## Local Setup & Installation

To get this project running on your local machine, follow these steps:

1. Clone the repository
git clone <your-repository-url>
cd badminton-league

2. Install dependencies
Make sure you have Ruby and Bundler installed, then run:
bundle install

3. Setup the database
This will create the database, load the schema, and run any migrations:
rails db:prepare

4. Start the server
rails server

Visit http://localhost:3000 in your browser to view the application!

## Running Tests

This application is fully tested using RSpec and FactoryBot, covering models, validations, database counter caches, and controller request routing. 

To run the test suite, execute:
bundle exec rspec

## AI Usage Disclaimer

Artificial Intelligence (AI) assistance was utilized during the development of this project. Specifically, AI tools were used to help generate and structure the RSpec test cases and to implement front-end UI/UX improvements using Bootstrap 5 classes. The core business logic, database schema design, and overarching application architecture were driven by human development.