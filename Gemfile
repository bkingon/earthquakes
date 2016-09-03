source 'https://rubygems.org'

ruby '2.3.1'

gem 'rails', '5.0.0.1'

gem 'faraday'

# CSS
gem 'foundation-rails'
gem 'slim-rails'
gem 'autoprefixer-rails'
gem 'bourbon', '~> 4.0'
gem 'neat', '~> 1.7'
gem 'sass-rails', '~> 5.0'

# JavaScript
gem 'coffee-rails'
gem 'jquery-rails'
gem 'therubyracer', platforms: :ruby
gem 'turbolinks'
gem 'uglifier'

group :development, :test do
  gem 'dotenv-rails'
  gem 'pry-rails'
end

group :development do
  gem 'byebug'
  gem 'better_errors'
  gem 'thin'
  gem 'web-console', '~> 2.0'
  gem 'rubycritic', :require => false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  group :darwin do # OSX Only
    gem 'terminal-notifier-guard'
  end
end

group :test do
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'launchy'
  gem 'simplecov'
  gem 'vcr'
  gem 'webmock'
end

group :production, :staging do
  gem 'rails_12factor'
end
