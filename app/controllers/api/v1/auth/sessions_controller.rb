module API
  module V1
    class SessionsController < BaseController
      skip_before_action :authenticate, only: :create

      def create
        result = Auths::Login.call(email: params[:email],
                                   password: params[:password])
        case result
        when Success
          render json: result.value!
        when Failure
          render_api_error(result.failure)
        end
      end
    end
  end
end
