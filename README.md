# verve-software-challenge

My submission for the [Verve Software Challenge](http://github.com/VerveWireless/software-challenge)

## Prerequisites

This application was written with Ruby on Rails, so it depends on Ruby, Rubygems, Bundler, and SQLite. Specific versions may not matter, but in case you run into compatibility issues, here are the versions I used during development:

* Ruby 2.0.0
* Rubygems 2.0.3
* Bundler 1.3.5
* SQLite 3.7.13

Installation of these packages are out of the scope of this document.


## Installation

Use bundler to install the application dependencies, and rake to create the database schema and migrate the database.

```
$ bundle install
$ rake db:migrate
```

## Running the App

To start the app in development mode, use the `rails server` command, and to view it, go to [localhost:3000](http://localhost:3000) with your favorite web browser.  

*Note: I used Google Chrome during development, but it should be compatible with recent versions of IE, Firefox, Chrome, and Opera.*