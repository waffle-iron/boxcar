[![Build Status](https://travis-ci.com/smashingboxes/smashing-template.svg?token=4zGd2Wnks9QoZVxC99Xw&branch=master)](https://travis-ci.com/smashingboxes/smashing-template)

# Smashing-Template

Smashing-Template is the Rails application template used at
[Smashing Boxes](https://smashingboxes.com/) according to our best practices.

## Requirements
This template currently assumes:
  - Rails 4.2.5
  - PostgreSQL

## Installation
To create a new Rails app with this template, run:
```
rails new [app_name] -m https://raw.githubusercontent.com/smashingboxes/smashing-template/master/template.rb
-B
```
Note that the -B is optional and equivalent to --skip-bundle. Since there is a bundle install command inside the template, the final bundle when creating a new Rails app is unnecessary.

## What does it do?
The template will do the following:
  1. Generate a Rails app
  2. Modify the Gemfile
  3. Include all necessary gem configs
  4. Remove Turbolinks throughout app
  5. Create README.md
  6. Generate a PostgreSQL database file
  7. Create all Travis files, including linting
  8. Modify the .gitignore
  9. Provide options for additional gems
  10. Run git:init

## Features
* Gemfile:

Smashing_Template includes the following gems:

  Application:
  - Rails default gems
  - Postgresql (pg) rather than sqlite3
  - Unicorn
  - Taperole

  Test and development:
  - rspec-rails
  - factory_girl_rails
  - database_cleaner
  - pry-byebug
  - awesome_print
  - rubocop
  - shoulda-matchers
  - codeclimate-test-reporter

  Development only:
  - web-console
  - spring

The following are removed:
* Turbolinks, from:
  - Gemfile
  - /application.js
  - /application.html.erb
* Test folder
* README.rdoc

The following are created:
* README.md, containing the app name
* All files generated by 'rspec:install'
* All files generated by 'tape installer install'
* A database.yml file with postgreslq config
* A rubocop.yml file with Ruby linting regulations

The following files are added to .gitnore:
* config/initializers/secret_token.rb
* config/secrets.yml
* config/database.yml

The following Travis files are created:
* .example files for both database and secrets
* .travis.yml file with all commands, including running rubocop as a local linter

The following configs are inserted:
Within 'rails_helper.rb'
* FactoryGirl gem
* DatabaseCleaner gem
* ShouldaMatchers gem
Within 'spec_helper.rb'
* CodeClimate gem

The following additional are optional:
* SmashingDocs
  - If you respond with 'yes':
    - The gem will be added into your Gemfile
    - All files and configs generated by 'docs:install' will be added
* Devise
  - If you respond with 'yes':
    - The gem will be added into your Gemfile
    - All files and configs generated by 'devise:install' will be added
* ActiveAdmin
- If you respond with 'yes':
  - The gem will be added into your Gemfile
  - If you do not yet have devise, that too will be added into your Gemfile
  - All files and configs generated by 'activeadmin:install' will be added
* Cucumber & Capybara
- If you respond with 'yes':
  - The gems will be added into your Gemfile
  - All files and configs generated by 'cucumber:install' will be added

* Git
  - Finally, the git repository is initialized with the command 'git init'
