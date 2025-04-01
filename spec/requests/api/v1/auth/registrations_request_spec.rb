require 'swagger_helper'

describe 'Registrations' do
  path '/api/v1/auth/sign_up' do
    post 'Register user' do
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
              password: { type: :string },
              first_name: { type: :string },
              last_name: { type: :string }
            },
            required: %i[email password first_name last_name]
          }
        }
      }

      response '201', 'Success' do
        schema type: :object, properties: {
          id: { type: :string, format: :uuid },
          email: { type: :string, format: :email },
          first_name: { type: :string },
          last_name: { type: :string },
          avatar_url: { type: :string, nullable: true }
        }
        let(:params) { { user: attributes_for(:user) } }
        run_test!
      end

      response '422', 'Failure' do
        schema type: :object, properties: {
          message: { type: :string, example: 'Unprocessable entity' },
          status: { type: :integer, example: 422 },
          errors: {
            type: :array,
            items: {
              type: :object,
              properties: {
                field: { type: :string, example: 'first_name' },
                message: { type: :string, example: "First name can't be blank" }
              }
            }
          }
        }
        let(:params) { { user: attributes_for(:user, first_name: nil) } }
        run_test!
      end
    end
  end
end
