class ApplicationController < ActionController::API
  include ExceptionFilter
  include JSONAPIRender

  include Pagination
  include Authentication

  include ActionController::Cookies

  wrap_parameters false

  before_action :set_current_request_details

  private

  def set_current_request_details
    Current.user_agent = request.user_agent
    Current.ip_address = request.remote_ip
  end

  def filter_params
    params[:filter].permit! || {}
  end

  def order_params
    params[:order].permit! || {}
  end
end
