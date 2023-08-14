module JSONAPI
  def json_response
    JSON.parse(response.body)
  end

  def auth_header(user)
    Devise::JWT::TestHelpers.auth_headers({}, user).fetch('Authorization', nil)
  end
end

RSpec.configure do |config|
  config.include JSONAPI, type: :request
end
