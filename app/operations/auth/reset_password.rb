module Auth
  class ResetPassword
    include Dry::Monads[:result]

    def call(token:, new_password:)
      user = User.find_by_token_for(:password_reset, token)
      return render_api_error(APIError::BadRequestError.new('Reset password token is invalid')) unless user

      user.update!(password: new_password)

      Success({
        message: 'Your password has been reset successfully.'
      })
    end
  end
end
