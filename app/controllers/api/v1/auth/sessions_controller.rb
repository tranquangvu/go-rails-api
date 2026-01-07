module API
  module V1
    module Auth
      class SessionsController < BaseController
        skip_before_action :authenticate, only: :create

        def create
          result = Users::Authenticate.call(
            email: params[:email],
            password: params[:password]
          )
          case result
          when Success
            data = result.value!
            set_refresh_token(value: data[:refresh_token], expires: data[:session].expired_at)
            render json: { user: data[:user], access_token: data[:access_token] }
          when Failure
            render_api_error(result.failure)
          end
        end

        def destroy
          Current.session.destroy!
          cookies.delete(:refresh_token)

          head :no_content
        end
      end
    end
  end
end
