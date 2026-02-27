module API
  module V1
    module Auth
      class SessionsController < BaseController
        skip_before_action :authenticate, only: %i[create refresh]

        def create
          result = Auth::LoginUser.call(**login_params)
          case result
          when Success
            response_session(result.value!)
          when Failure
            render_api_error(result.failure)
          end
        end

        def refresh
          result = Auth::RefreshSession.call(refresh_token)
          case result
          when Success
            response_session(result.value!)
          when Failure
            render_api_error(result.failure)
          end
        end

        def destroy
          Current.session.destroy!
          cookies.delete(:refresh_token)

          head :no_content
        end

        private

        def login_params
          params.expect(:email, :password)
        end

        def response_session(data)
          set_refresh_token(value: data[:refresh_token], expires: data[:session].expired_at)
          render json: { user: data[:user], access_token: data[:access_token] }.compact
        end
      end
    end
  end
end
