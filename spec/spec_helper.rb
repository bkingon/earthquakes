require 'dotenv'
require 'simplecov'
require_relative 'fixtures/all'

Dotenv.load

RSpec.configure do |config|

  SimpleCov.start 'rails' do
    add_filter 'app/channels'
    add_filter 'app/models'
    add_filter 'app/jobs'
    add_filter 'app/mailers/application_mailer.rb'
  end

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.order = :random
end
