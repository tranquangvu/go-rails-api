module V1
  class SessionsController < BaseController
    allow_unauthenticated_access only: %i[create]

    def create
      result = Auths::Login.new.call(create_params)

      if result.success?
        user, access_token, refresh_token = result.value!.values_at(:user, :access_token, :refresh_token)
        set_auth_cookies(access_token:, refresh_token:)
        render_resource(user)
      else
        render_error(result.failure)
      end
    end

    def refresh
    end

    def destroy
      terminate_session
      head :no_content
    end

    private

    def create_params
      params.permit(:email, :password)
    end
  end
end
