class ApplicationSerializer < Blueprinter::Base
  def self.file_url(object)
    return unless object.present?

    Rails.application.routes.url_helpers.file_url(signed_id: object.signed_id)
  end
end
