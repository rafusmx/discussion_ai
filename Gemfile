source "https://rubygems.org"

ruby "3.3.4"
gem "rails", "~> 7.1.4"
# gem "sqlite3", ">= 1.4"
gem "pg"
gem "puma", ">= 5.0"

gem "sprockets-rails"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "bootsnap", require: false

gem 'rest-client', '~> 2.0'
gem 'slim-rails', '~> 3.1', '>= 3.1.1'
gem 'sucker_punch'

gem "redis"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem "rspec-rails"
  gem 'webmock', '~> 3.23', '>= 3.23.1'
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "webdrivers"
  gem "selenium-webdriver"
end
