module API
  module V1
    module Auth
      class RefreshController < BaseController
        skip_before_action :authenticate

        def create
          refresh_token = cookies[:refresh_token] || params[:refresh_token]
          result = Auths::RefreshToken.call(refresh_token:)
          case result
          when Success
            data = result.value!
            headers['Authorization'] = "Bearer #{data[:access_token]}"
            render json: data[:user]
          when Failure
            render_api_error(result.failure)
          end
        end
      end
    end
  end
end
