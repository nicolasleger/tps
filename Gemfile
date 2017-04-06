source 'https://rubygems.org'

gem 'rails', '5.0.0.1'

gem 'actioncable', '5.0.0.1'
gem 'redis'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '~> 5.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Enable deep clone of active record models
gem 'deep_cloneable', '~> 2.2.1'

# Use Unicorn as the app server
gem 'unicorn'

# serializer
gem 'active_model_serializers'

# haml
gem 'haml-rails'

# bootstrap saas
gem 'bootstrap-sass', '~> 3.3.5'

# Pagination
gem 'will_paginate-bootstrap'

# Decorators
gem 'draper', '~> 3.0.0.pre1'

gem 'unicode_utils'

# Gestion des comptes utilisateurs
gem 'devise'
gem 'openid_connect'

gem 'rest-client'

gem 'clamav-client', require: 'clamav/client'

gem 'carrierwave'
gem 'fog'
gem 'fog-openstack'

gem 'pg'

gem 'rgeo-geojson'
gem 'leaflet-rails'
gem 'leaflet-markercluster-rails', '~> 0.7.0'
gem 'leaflet-draw-rails'

gem 'bootstrap-datepicker-rails'

gem 'chartkick'

gem 'logstasher'

gem 'font-awesome-rails'

gem 'hashie'

gem 'mailjet'

gem 'smart_listing'

gem 'bootstrap-wysihtml5-rails', '~> 0.3.3.8'

gem 'as_csv'
gem 'spreadsheet_architect'

gem 'apipie-rails'
# For Markdown support in apipie
gem 'maruku'

gem 'openstack'

gem 'browser'

gem 'simple_form'

gem 'newrelic_rpm'

gem 'scenic'

# Sidekiq
gem 'sidekiq'
gem 'sidekiq-cron', '~> 0.4.4'
gem 'sinatra', git: 'https://github.com/sinatra/sinatra.git', require: false

gem 'select2-rails'

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'factory_girl'
  gem 'database_cleaner'
  gem 'webmock'
  gem 'shoulda-matchers', require: false
  gem 'poltergeist'
  gem 'timecop'
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'guard-livereload', '~> 2.4', require: false
  gem 'vcr'
  gem 'rails-controller-testing'
  gem 'sqlite3'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console'
  gem 'rack-handlers'
  gem 'xray-rails'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'pry-byebug'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'rspec-rails', '~> 3.0'

  # Deploy
  gem 'mina', ref: '343a7', git: 'https://github.com/mina-deploy/mina.git'

  # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
  gem 'dotenv-rails'
end

group :production, :staging do
  gem 'sentry-raven'
end

