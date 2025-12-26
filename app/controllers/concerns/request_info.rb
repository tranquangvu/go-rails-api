module RequestInfo
  extend ActiveSupport::Concern

  included do
    before_action :set_request_info
  end

  private

  def set_request_info
    Current.user_agent = request.user_agent
    Current.ip_address = request.remote_ip
  end
end
