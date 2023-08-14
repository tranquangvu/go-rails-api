require 'devise/jwt/test_helpers'

RSpec.configure do |config|
  config.include Devise::Test::IntegrationHelpers, type: :request
end
