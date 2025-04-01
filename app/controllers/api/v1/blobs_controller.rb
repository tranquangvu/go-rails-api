module API
  module V1
    class BlobsController < BaseController
      def create
        authorize(ActiveStorage::Blob)
        blob = Blobs::Create.new.call(blob_params[:file])
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
end
