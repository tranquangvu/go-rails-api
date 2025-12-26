class ApplicationController < ActionController::API
  include Pundit::Authorization
  include Pagy::Backend
  include JSONAPIRender
  include ExceptionFilter
  include RequestInfo
  include Authentication

  def filter_params
    params.expect(:filter) || {}
  end

  def order_params
    params.expect(:order) || {}
  end
end
