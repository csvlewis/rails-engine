# Rails Engine

Rails engine is a JSON API capable of analyzing and returning data based off of [SalesEngine CSV data](https://github.com/turingschool-examples/sales_engine/tree/master/data). The API is compliant to the [JSON API spec](https://jsonapi.org/).

# Prerequisites

- Requires PostgreSQL database

# Getting Started

Clone the repo on your local machine from your terminal

    git clone https://github.com/csvlewis/rails-engine

Enter the newly created directory and bundle

  cd rails_engine
  bundle

Create and migrate the database

    rake db:{create, migrate}

Copy [SalesEngine CSV data](https://github.com/turingschool-examples/sales_engine/t`ree/master/data) into a folder name '/data' in the program's root directory

Run the 'import:csv' rake task to load CSV data

    rake import:csv

Launch a local server with 'rails s'

  rails s

Visit 'localhost:3000' in your internet browser

You can then enter queries by adding them to the URL. For example, if you wanted to get a list of all of the invoices for merchant 1, you could enter 'localhost:3000/api/v1/merchants/1/invoices' and get the JSON representation of that data.

All possible search queries can be found in the project description [here](http://backend.turing.io/module3/projects/rails_engine).

# Database Visualization

![Database Visualizaion](/db_schema.png?raw=true)

# How to Test

Rails Engine uses RSpec for testing. To run the full test suite, simply run 'rspec' from the terminal.

    rspec

Individual tests can be run by specifying the desired file path and line number. For example,

    rspec spec/requests/api/v1/customer_search_spec.rb:11

will run the customer_search_spec test that is found in that file on line 11.

# Built With

- Ruby on Rails Framework
- [FastJsonapi](https://github.com/Netflix/fast_jsonapi)

# Created By

- [Chris Lewis](https://github.com/csvlewis)
