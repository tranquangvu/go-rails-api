require 'swagger_helper'

describe 'Passwords' do
  let!(:user) { create(:user) }

  path '/api/v1/auth/password' do
    post 'Request reset password' do
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
          message: { type: :string, example: 'If your email address exists in our database, you will receive a password recovery link at your email address in a few minutes.' }
        }
        let(:params) { { user: { email: user.email } } }
        run_test!
      end
    end

    put 'Change password' do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              password: { type: :string },
              reset_password_token: { type: :string }
            },
            required: %i[password reset_password_token]
          }
        }
      }

      before do
        @token = user.send(:set_reset_password_token)
      end

      response '200', 'Success' do
        schema type: :object, properties: {
          message: { type: :string, example: 'Your password has been changed successfully' }
        }
        let(:params) { { user: { password: 'password123', reset_password_token: @token } } }
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
                field: { type: :string, example: 'reset_password_token' },
                message: { type: :string, example: 'Reset password token is invalid' }
              }
            }
          }
        }
        let(:params) { { user: { password: 'password123', reset_password_token: 'invalid-token' } } }
        run_test!
      end
    end
  end
end
