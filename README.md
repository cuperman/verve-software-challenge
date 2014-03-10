# verve-software-challenge

My submission for the [Verve Software Challenge](http://github.com/VerveWireless/software-challenge)

![CircleCI Status](https://circleci.com/gh/cuperman/verve-software-challenge/tree/master.png?circle-token=8733f0aaed82ce8106ff86a28978236195223bcc)

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

## API

Standard Rails API endpoints are exposed for Offer CRUD operations:

```
GET /offers
GET /offer/:id
POST /offers
PUT /offers/:id
DELETE /offers/:id
```

Additionally, the `GET /offers` request supports query string parameters `latitude`, `longitude`.  If you specify both latitude and longitude, it uses those values to calculate the distance for each offer, otherwise it uses the coordinates of the Verve Carlsbad office: (33.1243208, -117.32582479999996).

Once you import data from a TSV file, you can try it out by browsing to this URL (using the coordinates of Balboa Park): 

[http://localhost:3000/offers.json?latitude=32.7341479&longitude=-117.14455299999997](http://localhost:3000/offers.json?latitude=32.7341479&longitude=-117.14455299999997)

Refer to the `distance_in_miles` attribute for the distance between the business and the specified coordinate.  Results are ordered by distance.

## Tests

### Qunit

To view the qunit tests, go to [localhost:3000/tests/qunit](http://localhost:3000/tests/qunit) with your web browser.  This page is only accessible in development and test environments.

### Rspec

To run the rspec tests, use the `rspec` command.  The rspec tests also execute the qunit tests by inspecting the tests/qunit page.

## Continuous Integration

I'm using [CircleCI](https://circleci.com) for Continuous Integration.  Jonathan and I discussed this during the phone interview, so I wanted to add it to this project as an example.

It's configured to build every commit, run all unit tests, run [jshint](http://www.jshint.com/about) for Javascript static code analysis, and deploy to Heroku on success.  The badge at the top of the README indicates the current build status.

## Heroku Deployment

This app is deployed on [Heroku](http://www.heroku.com), so you can try it out by visiting:

[http://jcooper-verve-challenge.herokuapp.com](http://jcooper-verve-challenge.herokuapp.com)