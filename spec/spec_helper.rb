require 'dotenv'
require 'simplecov'
# require 'capybara/rspec'
# require 'capybara/webkit/matchers'
# Capybara.javascript_driver = :webkit

require_relative 'fixtures/all'

Dotenv.load

# Config docs: http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|

 # config.include(Capybara::Webkit::RspecMatchers, :type => :feature)

  # if config.files_to_run.one?
  #   config.default_formatter = 'doc'
  # else
  SimpleCov.start 'rails' do
    add_filter 'app/channels'
    add_filter 'app/models'
    add_filter 'app/jobs'
    add_filter 'app/mailers/application_mailer.rb'
  end
  # end

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.order = :random

  # config.include ControllerHelpers, type: :controller
end
