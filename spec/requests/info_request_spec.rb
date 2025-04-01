require 'swagger_helper'

describe 'Home' do
  describe 'GET /' do
    it 'returns ok response' do
      get '/'
      expect(response).to have_http_status(:ok)
    end
  end
end
