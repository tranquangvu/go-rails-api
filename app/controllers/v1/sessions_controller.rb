module V1
  class SessionsController < BaseController
    allow_unauthenticated_access only: %i[create]

    def create
      result = Auths::Login.new.call(login_params, request_info:)

      if result.success?
        user, access_token, refresh_token = result.value!.values_at(:user, :access_token, :refresh_token)
        set_auth_cookies(access_token:, refresh_token:)
        render_resource(user, 201)
      else
        render_api_error(result.failure)
      end
    end

    def destroy
      terminate_session
      head :no_content
    end

    private

    def login_params
      params.permit(:email, :password)
    end

    def request_info
      {
        user_agent: request.user_agent,
        ip_address: request.remote_ip
      }
    end
  end
end
