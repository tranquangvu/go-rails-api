class ApplicationSerializer < Blueprinter::Base
  def self.blob_url(signed_id)
    Rails.application.routes.url_helpers.blob_url(signed_id:)
  end
end
