# README

[<img src="https://travis-ci.org/railsgirlshh/railsgirlshh-registration.svg?branch=master" alt="Build Status" />](https://travis-ci.org/railsgirlshh/railsgirlshh-registration)

[ ![Codeship Status for railsgirlshh/railsgirlshh-registration](https://codeship.io/projects/5c35dfd0-48f8-0132-c0fe-2661e82857fb/status)](https://codeship.io/projects/46052)

Rails Girls Hamburg - attendee application and coach registration

## Setup

* In order to send emails, set the environment variables EMAIL_PASSWORD to our email password

* Set the environment variable MY_DOMAIN to the domain where the application is run

* Create an admin account on the console: AdminAccount.create(username: "foo", password_sha1: Digest::SHA1.hexdigest("bar"))

## Staging

* we continously deploy this repo's master branch to our staging environment