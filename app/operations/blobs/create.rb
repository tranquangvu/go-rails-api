module Blobs
  class Create < ApplicationOperation
    def call(file)
      validate_file!(file)
      create_and_upload!(file)
    end

    private

    def validate_file!(file)
      errors = []
      if file.size > Constants::UPLOADED_FILE_MAX_SIZE
        errors << "File size exceeds #{Constants::UPLOADED_FILE_MAX_SIZE / 1.megabyte}MB limit"
      end
      if Constants::UPLOADED_FILE_CONTENT_TYPES.exclude?(file.content_type)
        errors << "File type not allowed. Allowed types: #{Constants::UPLOADED_FILE_CONTENT_TYPES.join(', ')}"
      end
      raise APIError::BadRequestError.new(errors: errors) if errors.any?
    end

    def create_and_upload!(file)
      ActiveStorage::Blob.create_and_upload!(
        io: file.open,
        filename: file.original_filename,
        content_type: file.content_type
      )
    end
  end
end
