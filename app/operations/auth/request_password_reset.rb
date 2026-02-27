module Auth
  class RequestPasswordReset
    include Dry::Monads[:result]

    def call(email:)
      user = User.find_by(email:)
      UserMailer.with(user:).reset_password.deliver_later if user&.confirmed?

      Success({
        message: 'If your email is exists and confirmed, ' \
                 'you will receive a password recovery link at your email address in a few minutes.'
      })
    end
  end
end
