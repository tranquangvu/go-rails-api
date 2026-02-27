module Auth
  class LoginUser
    include Dry::Monads[:result]

    def initialize(jwt_encoder = JWT::Encoder.new)
      @jwt_encoder = jwt_encoder
    end

    def call(email:, password:)
      user = User.authenticate_by(email:, password:)
      return Failure(APIError::NotAuthenticatedError.new('Invalid email or password')) unless user

      session = create_session(user)
      access_token = jwt_encoder.call(
        user.jwt_payload,
        expired_at: (ENV.fetch('JWT_ACCESS_TOKEN_EXPIRES')&.to_i || 15).minutes.from_now
      )
      refresh_token = session.token

      Success({ user:, access_token:, refresh_token: })
    end

    private

    attr_reader :jwt_encoder

    def create_session(user)
      user.sessions.create!(token: SecureRandom.hex(32), expired_at: (ENV.fetch('JWT_REFRESH_TOKEN_EXPIRES')&.to_i || 7).days.from_now,
                            user_agent: Current.user_agent, ip_address: Current.ip_address)
    end
  end
end
