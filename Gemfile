# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.2"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 6.1.3.1"
# Use Puma as the app server
gem "puma", "~> 3.12"
# Use SCSS for stylesheets
gem "sass-rails", "~> 5"
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem "webpacker", "~> 4.0"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.7"
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.2", require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  # Easy installation and use of web drivers to run system tests with browsers
  gem "webdrivers"
  gem "webmock"
end

group :development, :test do
  gem "sqlite3", "~> 1.4"
end


# Not default

group :development, :test do
  # Pry
  gem "pry-rails"
  gem "pry-byebug"
  gem "pry-doc"

  # Test
  gem "rspec-rails"
  gem "factory_bot_rails"
end

group :production do
  gem "pg"
end

group :development do
  # Lint
  gem "rubocop", require: false
  gem "rubocop-packaging", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false

  # Lint
  gem "slim_lint"
  gem "html2slim"

  # N+1
  gem "bullet"
end

# Tamplate
gem "slim-rails"

# I18n
gem "rails-i18n", "~> 6.0.0"
gem "i18n-js"

# Twitter API
gem "twitter"

# .env
gem "dotenv-rails"

gem "omniauth"
gem "omniauth-twitter"
gem "omniauth-rails_csrf_protection"

gem "devise"
gem "devise-i18n"

# JavaScript
gem "jquery-rails"
gem "materialize-sass", "~> 1.0.0"
gem "material_icons"

# Pagination
gem "kaminari"
