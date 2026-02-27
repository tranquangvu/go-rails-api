module API
  module V1
    module Auth
      class ConfirmationsController < BaseController
        skip_before_action :authenticate, only: %i[create update]

        def create
          user = User.find_by(email: params[:email])
          UserMailer.with(user: user).confirm_email.deliver_later if user && !user.confirmed?

          render json: { message: 'If your email address exists in our database, you will receive an email with instructions for how to confirm your email address in a few minutes' }
        end

        def update
          user = User.find_by_token_for(:email_confirm, params[:confirmation_token])
          return render_api_error(APIError::BadRequestError.new('Confirmation token is invalid')) unless user

          user.update!(confirmed_at: Time.current)
          render json: { message: 'Your email address has been successfully confirmed' }
        end
      end
    end
  end
end
