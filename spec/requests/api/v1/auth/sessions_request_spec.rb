require 'swagger_helper'

RSpec.describe 'Sessions', type: :request do
  let!(:user) { create(:user, password: 'password123') }

  path '/api/v1/auth/sign_in' do
    post 'Sign in user' do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string, format: :email },
              password: { type: :string }
            },
            required: %i[email password]
          }
        }
      }

      response '200', 'Success' do
        schema type: :object, properties: {
          id: { type: :string, format: :uuid },
          email: { type: :string, format: :email },
          first_name: { type: :string },
          last_name: { type: :string },
          avatar_url: { type: :string, nullable: true }
        }
        header 'Authorization', schema: { type: :string, example: 'Bearer YOUR_TOKEN_HERE' }

        let(:params) { { user: { email: user.email, password: 'password123' } } }
        run_test!
      end

      response '401', 'Failure' do
        schema type: :object, properties: {
          message: { type: :string, example: 'Invalid email or password' },
          status: { type: :integer, example: 401 }
        }
        let(:params) { { user: { email: user.email, password: 'incorrect' } } }
        run_test!
      end
    end

    path '/api/v1/auth/sign_out' do
      delete 'Sign out user' do
        tags 'Authentication'
        consumes 'application/json'
        produces 'application/json'
        security [bearer_auth: {}]

        response '204', 'Success' do
          let(:Authorization) { auth_header(user) }
          run_test!
        end
      end
    end
  end
end
