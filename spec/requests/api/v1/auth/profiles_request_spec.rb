require 'swagger_helper'

RSpec.describe 'Profiles', type: :request do
  let!(:user) { create(:user, password: 'password123') }

  path '/api/v1/auth/profile' do
    get 'Get authenticated user' do
      tags 'Profile'
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: {}]

      response '200', 'Success' do
        schema type: :object, properties: {
          id: { type: :string, format: :uuid },
          email: { type: :string, format: :email },
          first_name: { type: :string },
          last_name: { type: :string },
          avatar_url: { type: :string, format: :uri, nullable: true }
        }
        let(:Authorization) { auth_header(user) }
        run_test!
      end
    end
  end

  path '/api/v1/auth/profile/general' do
    put 'Update user info' do
      tags 'Profile'
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: {}]
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              first_name: { type: :string },
              last_name: { type: :string },
              avatar: { type: :string, example: 'blob_signed_id' },
              current_password: { type: :string }
            },
            required: %i[current_password]
          }
        }
      }

      response '200', 'Success' do
        schema type: :object, properties: {
          id: { type: :string, format: :uuid },
          email: { type: :string, format: :email },
          first_name: { type: :string },
          last_name: { type: :string },
          avatar_url: { type: :string, format: :uri, nullable: true }
        }
        let(:Authorization) { auth_header(user) }
        let(:params) { { user: { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, current_password: 'password123' } } }
        run_test!
      end
    end
  end

  path '/api/v1/auth/profile/email' do
    put 'Update user email' do
      tags 'Profile'
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: {}]
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string, format: :email },
              current_password: { type: :string }
            },
            required: %i[email current_password]
          }
        }
      }

      response '200', 'Success' do
        schema type: :object, properties: {
          message: { type: :string }
        }
        let(:Authorization) { auth_header(user) }
        let(:params) { { user: { email: 'new@email.com', current_password: 'password123' } } }
        run_test!
      end
    end
  end

  path '/api/v1/auth/profile/password' do
    put 'Update user password' do
      tags 'Profile'
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: {}]
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              password: { type: :string },
              current_password: { type: :string }
            },
            required: %i[password current_password]
          }
        }
      }

      response '200', 'Success' do
        schema type: :object, properties: {
          message: { type: :string }
        }
        let(:Authorization) { auth_header(user) }
        let(:params) { { user: { password: 'password246', current_password: 'password123' } } }
        run_test!
      end
    end
  end
end
