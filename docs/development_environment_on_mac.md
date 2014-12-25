# What you need

* Homebrew
* Ruby 2.1.4
* Bundler
* PostgreSQL

## Install

we suspect you have homebrew already installed.

* start with installation of rbenv

```
brew install rbenv ruby-build ruby-install
```

* then install ruby 2.1.4 using rbenv

```
rbenv install 2.1.4
```

* fetch bundler from rubygems

```
gem install --no-rdoc --no-ri bundler
```

* install PostgreSQL

```
brew install postgresql
```

* create postgres user (note: version of postgresql may change)

```
/usr/local/Cellar/postgresql/9.4.0/bin/createuser  -s postgres
```

* install gems

```
bundle install
```

* setup database

```
rake db:create db:migrate
```

* **happy development**


## copy&paste installation

no warranty

```
brew install rbenv ruby-build ruby-install postgresql
rbenv install 2.1.4
gem install --no-rdoc --no-ri bundler
bundle install
rake db:create db:migrate
```
