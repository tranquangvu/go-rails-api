module Uploads
  class CreateAndUploadBlobService < ApplicationService
    MAX_SIZE_IN_MB = 50
    private_constant :MAX_SIZE_IN_MB

    attr_reader :file

    def initialize(file)
      @file = file
    end

    def call
      validate_file!
      create_and_upload!
    end

    private

    def validate_file!
      raise APIError::BadRequestError, "File size is too large, must be less than or equal to #{MAX_SIZE_IN_MB}MB" if file.size > MAX_SIZE_IN_MB.megabytes
    end

    def create_and_upload!
      ActiveStorage::Blob.create_and_upload!(
        io: file.open,
        filename: file.original_filename,
        content_type: file.content_type
      )
    end
  end
end
