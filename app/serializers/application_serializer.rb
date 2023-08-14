class ApplicationSerializer < Blueprinter::Base
  def self.url_for(object)
    return unless object.present?

    Rails.application.routes.url_helpers.url_for(object)
  end
end
