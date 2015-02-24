source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
gem 'pg'
gem 'bcrypt-ruby'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'flickraw-cached'
gem 'will_paginate'
gem 'friendly_id'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'rspec-rails'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem "mail_view", "~> 2.0.4"
  gem 'capistrano-novafabrica', :git => 'https://github.com/novafabrica/nf-cap-plugin'
  gem "capistrano-bundler"
  gem "capistrano-rails"
  gem 'capistrano-maintenance', github: "capistrano/maintenance", require: false
  gem 'factory_girl_rails'
  gem 'ffaker'
end

group :development do
  gem 'annotate'
end

group :test do
  gem 'rack_session_access'
  gem 'webmock'
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'simplecov', '~> 0.9', :require => false # Will install simplecov-html as a dependency
  gem 'database_cleaner'
  gem 'launchy'    # So you can do Then show me the page
  gem 'email_spec'
  gem 'shoulda-matchers'
  gem 'poltergeist'
  gem 'connection_pool'
end

