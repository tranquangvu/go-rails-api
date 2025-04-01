require 'swagger_helper'

describe 'Uploads' do
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
          signed_id: { type: :string },
          byte_size: { type: :integer },
          content_type: { type: :string },
          created_at: { type: :integer },
          filename: { type: :string },
          url: { type: :string }
        }
        let(:Authorization) { auth_header(user) }
        let(:blob) { { file: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/image.png'), 'image/png') } }
        run_test!
      end
    end
  end
end
