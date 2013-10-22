ruby "2.0.0"

source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use HAML for templates.
gem 'haml-rails'

# Use Boostrap 3 & a rich text editor that integrates nicely.
gem('anjlab-bootstrap-rails', require: 'bootstrap-rails',
    github: 'anjlab/bootstrap-rails')
gem 'bootstrap-wysihtml5-rails'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# Ember.js for client-side JavaScript.  Emblem gives us beautiful templates.
gem 'ember-rails'
gem 'ember-source', '1.0.0'
gem 'ember-data-source', '1.0.0.beta.3'
gem 'emblem-rails'

# Used to remove suspicious junk from HTML on cards.
gem 'sanitize'

# HTTP language detector.
gem 'http_accept_language'

# Compact language detector, courtesy of the Google Chrome team.
gem 'cld'

# A concurrent webserver.
# http://blog.codeship.io/2013/10/16/unleash-the-puma-on-heroku.html
gem 'puma'

# Password management.
gem 'bcrypt-ruby', '~> 3.0.0'

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :development do
  gem 'foreman'
  gem 'dotenv-rails'
end

group :development, :test do
  gem 'rspec-rails', '~> 2.0'
end

group :test do
  gem 'poltergeist'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem 'launchy'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
