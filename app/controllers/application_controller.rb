class ApplicationController < ActionController::API
  include Pundit::Authorization
  include Pagy::Backend
  include JSONAPIRender
  include ExceptionFilter

  private

  def filter_params
    params[:filter].permit! || {}
  end

  def order_params
    params[:order].permit! || {}
  end
end
