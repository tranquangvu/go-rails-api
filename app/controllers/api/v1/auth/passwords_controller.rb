module API
  module V1
    module Auth
      class PasswordsController < BaseController
        skip_before_action :authenticate, only: %i[create update]

        def create
          result = Auth::RequestPasswordReset.call(email: params[:email]&.strip&.downcase)
          render json: result.value!
        end

        def reset
          result = Auth::ResetPassword.call(
            token: params[:token],
            new_password: params[:new_password]
          )
          render json: result.value!
        end

        def update
        end
      end
    end
  end
end
