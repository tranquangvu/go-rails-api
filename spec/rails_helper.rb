require 'simplecov'
SimpleCov.start do
  add_filter 'config/'
  add_filter 'spec/'
  add_group 'Controllers', 'app/controllers'
  add_group 'Decorators', 'app/decorators'
  add_group 'Jobs', 'app/jobs'
  add_group 'Mailers', 'app/mailers'
  add_group 'Models', 'app/models'
  add_group 'Policies', 'app/policies'
  add_group 'Queries', 'app/queries'
  add_group 'Serializers', 'app/serializers'
  add_group 'Services', 'app/services'
end

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'faker'

Dir[Rails.root.join('spec/supports/**/*.rb')].each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
