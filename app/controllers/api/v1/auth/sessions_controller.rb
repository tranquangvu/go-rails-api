module API
  module V1
    module Auth
      class SessionsController < BaseController
        skip_before_action :authenticate, only: :create

        def create
          result = Auths::Login.call(
            email: params[:email],
            password: params[:password]
          )
          case result
          when Success
            data = result.value!
            headers['Authorization'] = "Bearer #{data[:access_token]}"
            cookies[:refresh_token] = {
              value: data[:refresh_token],
              expires: data[:session].expired_at,
              secure: true,
              httponly: true,
              same_site: :lax,
              path: '/api/v1/auth/refresh'
            }
            render json: data[:user]
          when Failure
            render_api_error(result.failure)
          end
        end

        def destroy
        end
      end
    end
  end
end
