# README

[<img src="https://travis-ci.org/railsgirlshh/railsgirlshh-registration.svg?branch=master" alt="Build Status" />](https://travis-ci.org/railsgirlshh/railsgirlshh-registration)

[![Code Climate](https://codeclimate.com/github/railsgirlshh/railsgirlshh-registration/badges/gpa.svg)](https://codeclimate.com/github/railsgirlshh/railsgirlshh-registration) [![Test Coverage](https://codeclimate.com/github/railsgirlshh/railsgirlshh-registration/badges/coverage.svg)](https://codeclimate.com/github/railsgirlshh/railsgirlshh-registration)

Rails Girls Hamburg - attendee application and coach registration

Do not mess with the production branch unless you know what you are doing - it is deployed continously to live!

## Setup

* In order to send emails, set the environment variables ```EMAIL_PASSWORD``` to our email password
* Set the environment variable ```MY_DOMAIN``` to the domain where the application is run
* Create an admin account on the console:<br>
```AdminAccount.create(username: "foo", password_sha1: Digest::SHA1.hexdigest("bar"))```
* Find more information in the docs folder (you can use ```rdoc``` to create a local version of the documentation, or browse files on github)

## Deployment
We deploy continously:
* master branch is continously deployed to our staging environment https://damp-shelf-5878.herokuapp.com/
* production branch is continously deployed to our live environment https://railsgirls-hamburg.herokuapp.com

### Regular Deployment
To deploy the current state of master to live: 
* merge master into production

### Hotfix Deployment
If you cannot deploy the current state of master to production (e.g. master build is not passing or the code is not sufficiently tested) and you have to deploy a critical fix to live:
* commit into the production branch to deploy your hotfix
* backmerge production into master
