# README

[<img src="https://travis-ci.org/railsgirlshh/railsgirlshh-registration.svg?branch=master" alt="Build Status" />](https://travis-ci.org/railsgirlshh/railsgirlshh-registration)

[ ![Codeship Status for railsgirlshh/railsgirlshh-registration](https://codeship.io/projects/5c35dfd0-48f8-0132-c0fe-2661e82857fb/status?branch=master)](https://codeship.io/projects/46052)

[![Code Climate](https://codeclimate.com/github/railsgirlshh/railsgirlshh-registration/badges/gpa.svg)](https://codeclimate.com/github/railsgirlshh/railsgirlshh-registration) [![Test Coverage](https://codeclimate.com/github/railsgirlshh/railsgirlshh-registration/badges/coverage.svg)](https://codeclimate.com/github/railsgirlshh/railsgirlshh-registration)

Rails Girls Hamburg - attendee application and coach registration

## Setup

* In order to send emails, set the environment variables ```EMAIL_PASSWORD``` to our email password
* Set the environment variable ```MY_DOMAIN``` to the domain where the application is run
* Create an admin account on the console: ```AdminAccount.create(username: "foo", password_sha1: Digest::SHA1.hexdigest("bar"))```
* Find more information in the docs folder (you can use ```rdoc``` to create a local version of the documentation, or browse files on github)


## Staging

* we continously deploy this repo's master branch to our staging environment https://damp-shelf-5878.herokuapp.com/
