module V1
  class UploadsController < BaseController
    def create
      authorize(ActiveStorage::Blob)
      blob = Uploads::CreateAndUploadBlobService.call(blob_params[:file])
      render_resource(blob, serializer: BlobSerializer, view: :detail, status: :created)
    end

    def show
      blob = authorize(ActiveStorage::Blob.find_signed!(params[:signed_id]))
      render_resource(blob, serializer: BlobSerializer, view: :detail)
    end

    private

    def blob_params
      params.require(:blob).permit(:file)
    end
  end
end
