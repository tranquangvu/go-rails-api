module Auths
  class Register
    include Dry::Monads[:result]

    def call(params)
      user = User.new(
        email: params[:email],
        password: params[:password],
      )
      if user.save
        UserMailer.with(user: user).verify_email.deliver_later
        Success(user)
      else
        Failure(APIError::RecordInvalidError.new(user.errors))
      end
    end
  end
end
