module JSONAPI
  def json_response
    JSON.parse(response.body)
  end

  def auth_header(user)
    # TODO: Return JWT auth header
  end
end

RSpec.configure do |config|
  config.include JSONAPI, type: :request
end
