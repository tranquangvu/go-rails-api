require 'swagger_helper'

describe 'Confirmations' do
  let!(:user) { create(:user, :need_confirmation) }

  path '/api/v1/auth/confirmation' do
    post 'Resend confirmation' do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string, format: :email }
            },
            required: %i[email]
          }
        }
      }

      response '200', 'Success' do
        schema type: :object, properties: {
          message: { type: :string, example: 'If your email address exists in our database, you will receive an email with instructions for how to confirm your email address in a few minutes' }
        }
        let(:params) { { user: { email: user.email } } }
        run_test!
      end
    end

    put 'Verify confirmation' do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              confirmation_token: { type: :string }
            },
            required: %i[confirmation_token]
          }
        }
      }

      response '200', 'Success' do
        schema type: :object, properties: {
          message: { type: :string, example: 'Your email address has been successfully confirmed' }
        }
        let(:params) { { user: { confirmation_token: user.confirmation_token } } }
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
                field: { type: :string, example: 'confirmation_token' },
                message: { type: :string, example: 'Confirmation token is invalid' }
              }
            }
          }
        }
        let(:params) { { user: { confirmation_token: 'invalid-token' } } }
        run_test!
      end
    end
  end
end
