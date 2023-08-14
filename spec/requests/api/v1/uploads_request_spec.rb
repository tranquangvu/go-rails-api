require 'swagger_helper'

RSpec.describe 'Uploads', type: :request do
  let!(:user) { create(:user) }

  path '/api/v1/uploads' do
    post 'Upload file' do
      tags 'Blobs'
      consumes 'multipart/form-data'
      produces 'application/json'
      security [bearer_auth: {}]

      parameter name: :blob, in: :formData, schema: {
        type: :object,
        properties: {
          file: { type: :file }
        },
        required: %i[file]
      }

      response '201', 'Success' do
        schema type: :object, properties: {
          signed_id: { type: :string, example: 'eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaEpJaWxqWWpRM09UaGxZeTFsTlRnMUxUUTVZakF0WVRobFl5MW1PRE15WkdRMU9ESmlNVGNHT2daRlZBPT0iLCJleHAiOm51bGwsInB1ciI6ImJsb2JfaWQifX0=--2818ad28efa9dfee79453b700aaa73f57228fbe1' },
          byte_size: { type: :integer, example: 1.kilobyte },
          content_type: { type: :string, example: 'image/png' },
          created_at: { type: :integer, example: Time.current.to_i },
          filename: { type: :string, example: 'image.png' },
          url: { type: :string, format: :uri, example: Rails.application.routes.url_helpers.rails_service_blob_url('eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaEpJaWxqWWpRM09UaGxZeTFsTlRnMUxUUTVZakF0WVRobFl5MW1PRE15WkdRMU9ESmlNVGNHT2daRlZBPT0iLCJleHAiOm51bGwsInB1ciI6ImJsb2JfaWQifX0=--2818ad28efa9dfee79453b700aaa73f57228fbe1', 'image.png') }
        }
        let(:Authorization) { auth_header(user) }
        let(:blob) { { file: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/image.png'), 'image/png') } }
        run_test!
      end
    end
  end
end
