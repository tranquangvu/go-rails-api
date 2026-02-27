module Auth
  class RegisterUser
    include Dry::Monads[:result]

    def call(name:, email:, password:)
      user = User.create!(name:, email:, password:)
      UserMailer.with(user: user).verify_email.deliver_later

      Success(user)
    end
  end
end
