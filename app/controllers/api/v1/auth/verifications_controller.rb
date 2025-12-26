module API
  module V1
    class VerificationsController < BaseController
      skip_before_action :authenticate, only: :show

      def create
        UserMailer.with(user: Current.user).email_verification.deliver_later
        render json: { message: 'If your email address exists in our database, you will receive an email with instructions for how to confirm your email address in a few minutes' }
      end

      def update
        user = User.find_by_token_for(:verification, update_params[:verification_token])
        raise APIError::BadRequestError, 'Invalid verification token' unless user

        user.update!(verified: true)
        render json: { message: 'Your account has been successfully confirmed' }, status: :ok
      end

      private

      def update_params
        params.expect(user: [:verification_token])
      end
    end
  end
end
