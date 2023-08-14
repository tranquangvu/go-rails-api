require 'rails_helper'

RSpec.describe 'Health', type: :request do
  describe 'GET /' do
    it 'returns ok response' do
      get root_path
      expect(response).to have_http_status(:ok)
    end
  end
end
