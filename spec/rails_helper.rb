ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)

require 'spec_helper'
require 'rspec/rails'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = Rails.root.join('spec', 'vcr')
  config.hook_into :webmock
end

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = true
end
