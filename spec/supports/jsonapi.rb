module JSONAPI
  def json_response
    JSON.parse(response.body)
  end

  def auth_header(user)
    # TODO: Implement a method to generate the authorization header for the user
  end
end

RSpec.configure do |config|
  config.include JSONAPI, type: :request
end
